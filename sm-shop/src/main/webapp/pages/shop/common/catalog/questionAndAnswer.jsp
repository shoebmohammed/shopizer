<%
response.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", -1);
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="/WEB-INF/shopizer-tags.tld" prefix="sm"%>

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<div class="questionAndAnswerSection">
  <h2>Question And Answer</h2>
  <div class="questionAndAnswer" style="height : 50vh; overflow: auto;">
    <div>
      <h4>1. How is the build material</h4>
      <h5>A. It feels premium. I have been using it for a while now and I have not faced any problem till now.</h5>
      <p class="replyLink replyLink" id="1" style="font-size: 80%; margin-left: 17px; cursor: default; color:blue;">Leave
        a Reply</p>
      <textarea class="form-control 1" placeholder="Your reply" style="display: none; margin-left: 15px; width: 90%"
        rows="2" cols="2"> </textarea>
      <button type="submit" class="btn btn-default submitReply 1" style="margin-top: 5px;margin-left: 15px; display:none;"
        value='${product.id}'>Submit</button>
    </div>
    <div>
      <br>
      <h4>2. How is the color after a while</h4>
      <h5>A. It does not fadeds out. I have been using it for a while now and I have not faced any problem till now.</h5>
      <p class="replyLink replyLink" id="2" style="font-size: 80%; margin-left: 17px; cursor: default; color:blue">Leave
        a Reply</p>
      <textarea class="form-control 2" placeholder="Your reply" style="display: none; margin-left: 15px; width: 90%"
        rows="2" cols="2"> </textarea>
      <button type="submit" class="btn btn-default submitReply 2" style="margin-top: 5px;margin-left: 15px; display:none;"
        value='${product.id}'>Submit</button>
    </div>
    <div>
      <br>
      <h4>3. Do you recomend this product</h4>
      <h5>A. Yes, I do. I have been using it for a while now and I have not faced any problem till now.</h5>
      <p class="replyLink replyLink" id="3" style="font-size: 80%; margin-left: 17px; cursor: default; color:blue">Leave
        a Reply</p>
      <textarea class="form-control 3" placeholder="Your reply" style="display: none; margin-left: 15px; width: 90%"
        rows="2" cols="2"> </textarea>
      <button type="submit" class="btn btn-default submitReply 3" style="margin-top: 5px;margin-left: 15px; display:none;"
        value='${product.id}'>Submit</button>
    </div>
    <div>
      <br>
      <h4>4. How is the color after a while</h4>
      <h5>A. It does not fadeds out. I have been using it for a while now and I have not faced any problem till now.</h5>
      <p class="replyLink replyLink" id="4" style="font-size: 80%; margin-left: 17px; cursor: default; color:blue">Leave
        a Reply</p>
      <textarea class="form-control 4" placeholder="Your reply" style="display: none; margin-left: 15px; width: 90%"
        rows="2" cols="2"> </textarea>
      <button type="submit" class="btn btn-default submitReply 4" style="margin-top: 5px;margin-left: 15px; display:none;"
        value='${product.id}'>Submit</button>
    </div>
  </div>
  <div class="form-group">
    <label for="questions">Query :</label>
    <textarea class="form-control" id="userQuery" rows="5" cols="3" id="questions" placeholder="Your Query here...."></textarea>
    <button type="submit" class="btn btn-default submitQuery" style="margin-top: 5px" value='${product.id}'>Submit</button>
  </div>
</div>

<script>
  $(document).ready(function () {
    function getUserName() {
      var user = $.cookie('user');
      var code = new Array();
      if (user != null) {
        user = user.replace(/['"]+/g, '');
        code = user.split('_');
        if (code[0] == getMerchantStoreCode()) {
          return code[1];
        }
      }
    }
    $('.replyLink').click(function (event) {
      const id = event.target.id;
      var userID = getUserName();
      if (userID) {
        if (document.getElementsByClassName(id)[0].style.display == 'block') {
          document.getElementsByClassName(id)[0].style.display = 'none';
          document.getElementsByClassName(id)[1].style.display = 'none';
        } else {
          document.getElementsByClassName(id)[0].style.display = 'block';
          document.getElementsByClassName(id)[1].style.display = 'block';
        }
      } else {
        alert('User Not logged In');
      }
    })
    $('.submitQuery').click(function (event) {
      const userID = getUserName();
      if (userID) {
        const productID = event.target.value;
        const userQuery = document.getElementById('userQuery').value;
        $.ajax({
          url: '<c:url value="/shop/product/query/save"/>',
          type: 'GET',
          dataType: "json",
          data: {
            userID: userID,
            productID: productID,
            query: userQuery,
          },
          success: function (response) {
            console.log(response);
          }
        });
      } else {
        alert('User Not logged In');
      }
    })
    $('.submitReply').click(function (event) {
      const userReply = $(event.target).prev().val();
      const productID = event.target.value;
      $.ajax({
        url: 'shop/product/reply/save',
        type: 'POST',
        dataType: "json",
        data: {
          userID: userID,
          productID: productID,
          queryID: queryID,
          query: userQuery,
        },
        success: function (response) {
          console.log(response);
        }
      });
    })
  });
</script>