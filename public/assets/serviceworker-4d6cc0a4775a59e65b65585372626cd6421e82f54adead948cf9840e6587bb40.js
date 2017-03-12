console.log('[Service Worker] Hello world!');

var CACHE_NAME = 'v1-cached-assets'
var focusOrOpenWindow, openURL;

openURL = function(clients, url) {
  return clients.matchAll({
    type: "window"
  }).then(focusOrOpenWindow.bind(self, url));
};

focusOrOpenWindow = function(url, windowClients) {
  var client, i, len;
  for (i = 0, len = windowClients.length; i < len; i++) {
    client = windowClients[i];
    if (client.url === url && "focus" in client) {
      return client.focus().then(function(focusedClient) {
        if ("navigate" in focusedClient) {
          return focusedClient.navigate(focusedClient.url);
        }
      });
    }
  }
  if (clients.openWindow) {
    return clients.openWindow(url);
  }
};



  
function onInstall(event) {
  event.waitUntil(
    caches.open(CACHE_NAME).then(function prefill(cache) {
      return cache.addAll([
        '/assets/application-e2fc838466eb7f662cb131747778504945bb68d0cd671462c291478a757e7d7e.js',
        '/assets/application-0b75d7b5af22435992c3d11a348550edd5cfc297b980dcb02ea89f982fcb6f2a.css',
      //  '/offline.html',
        // you get the idea ...
      ]);
    })
  );
}

function onActivate(event) {
  console.log('[Serviceworker]', "Activating!", event);
  event.waitUntil(
    caches.keys().then(function(cacheNames) {
      return Promise.all(
        cacheNames.filter(function(cacheName) {
          // Return true if you want to remove this cache,
          // but remember that caches are shared across
          // the whole origin
           return cacheName.indexOf('v1') !== 0;
        }).map(function(cacheName) {
          return caches.delete(cacheName);
        })
      );
    })
  );

}

self.addEventListener('install', onInstall)
self.addEventListener('activate', onActivate)



self.addEventListener("push", function(event) {
  var json = event.data.json();
  var icon = json.icon;
  var data= {
    doge: {
      url: json.url,
      user: json.user
    }
  };
    console.log(json);
    event.waitUntil(self.registration.showNotification(json.title, {
    body: json.body,
    data: data,
   icon: icon
  }));
 
});



self.addEventListener('notificationclick', function(event) {
  console.log('[Service Worker] Notification click Received.');
  var doge = event.notification.data.doge;
  console.log(doge.wow);
  event.notification.close();

  event.waitUntil(    
    clients.openWindow(doge.url)
  );
});



