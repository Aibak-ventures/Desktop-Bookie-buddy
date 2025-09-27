'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "d0c82db3cc7fac8ffe5f09650dd04035",
"assets/AssetManifest.bin.json": "6f1a56c44875622564d85ae346b437ca",
"assets/AssetManifest.json": "976eaa17a88af4e55cc357884f5f7ea8",
"assets/assets/animations/ani.json": "6f2f630dddddcd33d7429f1694747397",
"assets/assets/animations/erro_505_ani.json": "ef86708063b869ef7c06449458b55f3f",
"assets/assets/animations/nodata.json": "536812f351c00abfff3439b2186f59ca",
"assets/assets/animations/no_product_animation.json": "1364b16f8027360deb948ed969ab0f40",
"assets/assets/animations/search.json": "e5659f62a2eabd755135bbf887c68386",
"assets/assets/fonts/Inter.ttf": "0a77e23a8fdbe6caefd53cb04c26fabc",
"assets/assets/fonts/Inter_ExtraBold.ttf": "7c8dddeead3a39ebb25d4be0e0c4b876",
"assets/assets/fonts/Inter_Medium.ttf": "4591e900425d177e6ba268d165bf12e8",
"assets/assets/fonts/Inter_Regular.ttf": "e48c1217adab2a0e44f8df400d33c325",
"assets/assets/fonts/Inter_SemiBold.ttf": "c77560a8441d664af3e65dd57026dff9",
"assets/assets/fonts/MaterialIcons-Regular.ttf": "5260ab8a5dedcc51ef4056311b248bbb",
"assets/assets/fonts/NotoSansMalayalam.ttf": "7332db0366452211dc47bddedec78741",
"assets/assets/fonts/Poppins-Regular.ttf": "093ee89be9ede30383f39a899c485a82",
"assets/assets/icons/cash-icon.png": "928167a7eba6c85968d032fc64c84f31",
"assets/assets/icons/filter.svg": "34afbe4a66facde04ce9b01040360530",
"assets/assets/icons/home.svg": "b4c2dbefc99dbb015b360d77bd848c35",
"assets/assets/icons/info_danger.svg": "ba58fde3bcb5cb70622db4772db9b4a8",
"assets/assets/icons/invalid-date-icon.png": "ef6136cdaf357b4d8901845af518f813",
"assets/assets/icons/search.svg": "2f15af6c8a156b123ee35d3e91a232cb",
"assets/assets/icons/symbol.png": "e88ad851f1732269c425ea957209ca5d",
"assets/assets/icons/upi-icon.webp": "465895d241a6252bcabbdceb8aabe86f",
"assets/assets/icons/user.png": "3a0719e5ff7beb667f51df8f2932af0e",
"assets/assets/icons/whatsapp.svg": "f50ff8bec93ec74428f63e76ffcd945e",
"assets/assets/images/app_icon_dart.png": "ca2295f2b0ce4f5eff5c2ead782e7ed8",
"assets/assets/images/app_icon_light.png": "525ade33657b025924bd3c0a8081ef13",
"assets/assets/images/bg.png": "c2cff2b5d9c22c77ff08ef2ddd0612ce",
"assets/assets/images/brand_dark_img.png": "fc760a63d8cf952e502e469f6f7dd770",
"assets/assets/images/brand_light_img.png": "98527cd58c5dbb62711fb65f31a79d77",
"assets/assets/images/logo_dark.png": "ca2295f2b0ce4f5eff5c2ead782e7ed8",
"assets/assets/images/logo_light.png": "525ade33657b025924bd3c0a8081ef13",
"assets/assets/images/onboarding_person_image.png": "5ad3e20ebe6d234597408cb79c263e13",
"assets/assets/images/onboarding_person_image.svg": "6fb089eec6be2a83f946822e4224f221",
"assets/assets/images/product_3d.webp": "6b5d217d3733ad7d2964ebd804ce35fa",
"assets/assets/images/reset.png": "d051c6d60b09b74ed75a6798fc0a0aa4",
"assets/assets/images/select.png": "267823ca3e0d853ad5720950cce4bd6b",
"assets/assets/images/unknown_product.png": "e41257f6664ff561a45f6c9543fce9df",
"assets/FontManifest.json": "5137617dc1718a2dd32e4ca49db8277f",
"assets/fonts/MaterialIcons-Regular.otf": "deb2cd0685cd22374a695592a8c9bbf4",
"assets/NOTICES": "ee6e9731d368e4e05122a6472d278c8c",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w100.ttf": "64144aa1aa76d2b82813658df2a26c79",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w200.ttf": "d88bfd6ad62ffb93fb21a930431405f7",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w300.ttf": "930b720a5d939c5e880b5b5db9087ad1",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w400.ttf": "0fa0c68ca0b2e71120150346577b89cf",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w500.ttf": "2380c4b0a5e2fc1290cdd266003d6a5e",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w600.ttf": "1dd6fffeb3cb7e347be36f9d80e51767",
"assets/packages/lucide_icons_flutter/assets/lucide.ttf": "5b249b2a80c50f482a9bc65046acd324",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "780ce5f8bbd52380037a254222d1e703",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "7ea4586136a0745e51677cd10a63fb9c",
"/": "7ea4586136a0745e51677cd10a63fb9c",
"main.dart.js": "12b6bcd532df4b1058cb08d008c7ab59",
"manifest.json": "5da4d3dbb04040378fe5df88fbcc33d5",
"version.json": "548a8a6c27b8fc2ddfbead6ccc5f172c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
