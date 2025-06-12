let latestPayload = null;

chrome.runtime.onMessageExternal.addListener(
  function(request, sender, sendResponse) {
    if (sender.url && sender.url.startsWith("http://localhost/")) {
        console.log(request);
        if (request && request.action && request.action === "open_extension") {
            latestPayload = request;
            chrome.action?.openPopup();
            sendResponse({status: true});
        } 
        else if(request && request.action && request.action === "popup_extension"){
            latestPayload = request;
            chrome.windows.create({
                url: "index.html",
                type: "popup",
                width: 400,
                height: 600
                });
        }
        else {
            latestPayload = request;
            sendResponse({status: false});
        }
    } else {
      // If sender is not from your trusted source
      sendResponse({status: false});
    }
  }
);

chrome.runtime.onMessage.addListener(function(request, sender, sendResponse) {
  if (request === "get_latest_data") {
    sendResponse(latestPayload);
  } else {
    sendResponse({status: false});
  }
});
