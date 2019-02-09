// record every view to history
function addToHistory(e) {
  const pid = $(e.target).data('id');
  // alert(pid);
  $.ajax({
    url: 'http://localhost:8080/shop/product/alex-history',
    type: 'POST',
    data: JSON.stringify(pid),
    contentType: "application/json",
  });
}

// get most-viewed and insert it inside most-viewed generic/pages/product.jsp
function getMostViewed() {
  $.get({
    url: 'http://localhost:8080/shop/product/most-viewed',
    type: 'GET',
  });
}
