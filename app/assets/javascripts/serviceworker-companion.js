$( document ).ready(function() {
var login= getUrlParameter('login');

  if (navigator.serviceWorker) {
    navigator.serviceWorker.register('/serviceworker.js')
    .then(function(reg) {
      console.log('Service worker change, registered the service worker');

    });
    registerDevice();
  }
  // Otherwise, no push notifications :(
  else {
    console.error('Service worker is not supported in this browser');
  }
  





var logout= getUrlParameter('logout');

if(logout=="true")
{
  navigator.serviceWorker.ready.then(function(reg) {
    reg.pushManager.getSubscription().then(function(subscription) {
      subscription: subscription,

      subscription.unsubscribe().then(function(successful) {
        // You've successfully unsubscribed
        
        $.post('/unsubscribe',{
          subscription: subscription.toJSON()
        });
      }).catch(function(e) {
        // Unsubscription failed
      })

               navigator.serviceWorker.getRegistrations().then(function(registrations) {
          for(let registration of registrations) {
           registration.unregister()
         } })

    })        
  });
 
}

});



var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {

            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
};

function registerDevice()
{
  if (navigator.serviceWorker) {
  navigator.serviceWorker.ready.then((serviceWorkerRegistration) => {
    serviceWorkerRegistration.pushManager
    .subscribe({
      userVisibleOnly: true,
      applicationServerKey: window.vapidPublicKey
    });
    serviceWorkerRegistration.pushManager.getSubscription()
      .then((subscription) => {
        $.post('/devices/', {
          subscription: subscription.toJSON()
          
        });
      });
  });
  }
}



