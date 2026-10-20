// Language toggle (한국어 | English) injected into every DocC page by Scripts/inject-lang-toggle.sh.
// The Korean site lives at <base>/ and the English site at <base>/en/.
(function () {
  "use strict";

  var script = document.currentScript || document.querySelector("script[data-lang-toggle]");
  var base = ((script && script.getAttribute("data-base")) || "").replace(/\/$/, "");
  var enRoot = base + "/en";
  var TUTORIALS_HOME = "/tutorials/yacht-dice-with-tabletopkit/";
  var DOCUMENTATION_HOME = "/documentation/yachtdice/";

  function currentLang() {
    var p = location.pathname;
    return p === enRoot || p.indexOf(enRoot + "/") === 0 ? "en" : "ko";
  }

  function langRoot(lang) {
    return lang === "en" ? enRoot : base;
  }

  // The path inside the current language's site, always starting with "/".
  function relativePath() {
    var rest = location.pathname.slice(langRoot(currentLang()).length);
    return rest.charAt(0) === "/" ? rest : "/" + rest;
  }

  function targetUrl(lang) {
    return langRoot(lang) + relativePath();
  }

  // Used when the other language has no page at the same path (for example the
  // Korean-only API reference pages) or when we are on a site's empty root.
  function fallbackUrl(lang) {
    var home = relativePath().indexOf("/documentation") === 0 ? DOCUMENTATION_HOME : TUTORIALS_HOME;
    return langRoot(lang) + home;
  }

  function go(lang) {
    var isRoot = relativePath() === "/";
    if (isRoot) {
      location.assign(fallbackUrl(lang));
      return;
    }
    var url = targetUrl(lang);
    fetch(url, { method: "HEAD", cache: "no-store" })
      .then(function (res) { location.assign(res.ok ? url : fallbackUrl(lang)); })
      .catch(function () { location.assign(url); });
  }

  var css =
    ".yd-lang-toggle{position:fixed;right:16px;bottom:calc(16px + env(safe-area-inset-bottom,0px));z-index:10000;" +
    "display:flex;padding:3px;gap:2px;border-radius:999px;font:500 13px/1 -apple-system,BlinkMacSystemFont,'Helvetica Neue',Arial,sans-serif;" +
    "background:var(--color-fill,#fff);border:1px solid var(--color-grid,#d2d2d7);box-shadow:0 2px 10px rgba(0,0,0,.14);}" +
    ".yd-lang-toggle a{display:block;padding:7px 13px;border-radius:999px;color:var(--color-text,#1d1d1f);text-decoration:none;cursor:pointer;}" +
    ".yd-lang-toggle a:hover{background:var(--color-fill-gray-quaternary,rgba(0,0,0,.06));}" +
    ".yd-lang-toggle a[aria-current=true]{background:var(--color-link,#0066cc);color:#fff;cursor:default;}" +
    ".yd-lang-toggle a:focus-visible{outline:2px solid var(--color-link,#0066cc);outline-offset:2px;}" +
    "@media print{.yd-lang-toggle{display:none;}}";

  function build() {
    if (document.querySelector(".yd-lang-toggle")) return;

    var style = document.createElement("style");
    style.textContent = css;
    document.head.appendChild(style);

    var nav = document.createElement("nav");
    nav.className = "yd-lang-toggle";
    nav.setAttribute("aria-label", "Language / 언어");

    var links = [
      { lang: "ko", label: "한국어" },
      { lang: "en", label: "English" }
    ].map(function (item) {
      var a = document.createElement("a");
      a.textContent = item.label;
      a.lang = item.lang;
      a.hreflang = item.lang;
      a.addEventListener("click", function (event) {
        event.preventDefault();
        if (item.lang !== currentLang()) go(item.lang);
      });
      nav.appendChild(a);
      return { el: a, lang: item.lang };
    });

    // DocC changes the URL with history.pushState, so refresh state whenever it can matter.
    function refresh() {
      var current = currentLang();
      links.forEach(function (link) {
        var isCurrent = link.lang === current;
        if (isCurrent) link.el.setAttribute("aria-current", "true");
        else link.el.removeAttribute("aria-current");
        link.el.href = isCurrent ? location.pathname : targetUrl(link.lang);
      });
    }
    ["mouseover", "focusin", "touchstart"].forEach(function (name) {
      nav.addEventListener(name, refresh, { passive: true });
    });
    window.addEventListener("popstate", refresh);
    refresh();

    document.body.appendChild(nav);
  }

  build();
})();
