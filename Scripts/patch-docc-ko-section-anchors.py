#!/usr/bin/env python3
"""Give Korean Swift-DocC tutorial sections stable ASCII navigation anchors.

Usage: python3 Scripts/patch-docc-ko-section-anchors.py site
Run after both DocC sites are generated, before upload-pages-artifact.
Only site/data (Korean) is edited; site/en/data (English) is untouched.
"""
from __future__ import annotations
import json
import sys
from pathlib import Path
from urllib.parse import quote


def main(site: Path) -> None:
    ko_data = site / "data"
    tutorials_dir = ko_data / "tutorials" / "yachtdice"
    if not tutorials_dir.is_dir():
        raise SystemExit(f"Korean tutorial JSON folder missing: {tutorials_dir}")

    replacements: dict[str, str] = {}
    per_file_anchors: dict[Path, dict[str, str]] = {}
    fixed_sections = 0

    for path in sorted(tutorials_dir.glob("*.json")):
        page = json.loads(path.read_text(encoding="utf-8"))
        identifier = page.get("identifier", {}).get("url")
        if not identifier:
            continue
        url_path = "/" + path.relative_to(ko_data).with_suffix("").as_posix()
        for section in page.get("sections", []):
            if section.get("kind") != "tasks":
                continue
            for n, task in enumerate(section.get("tasks", []), start=1):
                old = task.get("anchor", "")
                if not old or old.isascii():
                    continue  # English-only titles and the assessment anchor already work.
                new = f"section-{n}"
                per_file_anchors.setdefault(path, {})[old] = new
                old_encoded = quote(old, safe="-._~")
                for fragment in {old, old_encoded}:
                    replacements[f"{identifier}#{fragment}"] = f"{identifier}#{new}"
                    replacements[f"{url_path}#{fragment}"] = f"{url_path}#{new}"
                fixed_sections += 1

    if fixed_sections == 0:
        print("No non-ASCII Korean section anchors found; nothing to change.")
        return

    # Patch the generated Korean render JSON everywhere references occur:
    # task sections, the tutorial table of contents, and reference dictionaries.
    changed_files = 0
    for path in sorted(ko_data.rglob("*.json")):
        text = path.read_text(encoding="utf-8")
        if not any(old in text for old in replacements) and path not in per_file_anchors:
            continue
        data = json.loads(text)

        def rewrite(value):
            if isinstance(value, str):
                for old, new in replacements.items():
                    if old in value:
                        value = value.replace(old, new)
                return value
            if isinstance(value, list):
                return [rewrite(item) for item in value]
            if isinstance(value, dict):
                return {rewrite(k): rewrite(v) for k, v in value.items()}
            return value

        data = rewrite(data)
        anchors = per_file_anchors.get(path)
        if anchors:
            for section in data.get("sections", []):
                if section.get("kind") == "tasks":
                    for task in section.get("tasks", []):
                        task["anchor"] = anchors.get(task.get("anchor"), task.get("anchor"))
        path.write_text(json.dumps(data, ensure_ascii=False, separators=(",", ":")) + "\n", encoding="utf-8")
        changed_files += 1

    print(f"Patched {fixed_sections} Korean section anchors across {changed_files} JSON files.")
    print("English site/en/ was not modified.")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        raise SystemExit("Usage: python3 patch-docc-ko-section-anchors.py <site-output-directory>")
    main(Path(sys.argv[1]))
