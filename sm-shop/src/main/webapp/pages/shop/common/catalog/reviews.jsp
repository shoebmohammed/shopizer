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
								
										<sec:authorize access="!hasRole('AUTH_CUSTOMER') and fullyAuthenticated">
											<!-- no dual login -->
											<div id="signin" class="">
											<ul class="list-unstyled">
												<li>
													<s:message code="label.security.loggedinas" text="You are logged in as"/> [<sec:authentication property="principal.username"/>]. <s:message code="label.security.nologinacces.store" text="We can't display store logon box"/>
												</li>
											</ul>
											</div>
										</sec:authorize>
										<sec:authorize access="hasRole('AUTH_CUSTOMER') and fullyAuthenticated">
								  			<a href="<c:url value="/shop/customer/review.html"/>?productId=${product.id}"/><button id="reviewButton" type="submit" class="btn btn-default"><s:message code="label.product.reviews.write" text="Write a review" /></button></a>
								  		</sec:authorize>
								  		<sec:authorize access="!hasRole('AUTH_CUSTOMER') and !fullyAuthenticated">
								  			<p class="muted"><s:message code="label.product.reviews.logon.write" text="You have to be authenticated to write a review" /></p>
								  		</sec:authorize>
    <%--pradeep added this div--%>
<div class="row">
<div class="col-md-5">
	<div>
	<h2>Star Rating</h2>
		<div id="averageRating"></div>
        <div>
        </div>
	</div><br />
  <div>
	  <ul>
		  <li class="row" style="display: flex; margin-bottom: 5px">
			  <a aria-label="5 star (86%)" class="a-size-small a-link-normal 5star col-md-3" title="5 star" href="" style="padding-left: 15px; padding-right: 0; ">5 star</a>
			  <div class="progress col-md 4" style="width:40%; margin: 0; ">
				  <div class="progress-bar" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width:70%">
					  <span class="sr-only">70% Complete</span>
				  </div>
			  </div>
			  <a class="a-size-base a-link-normal 5star histogram-review-count a-color-secondary col-md-3" tabindex="-1" href="" style="" >70%</a>
		  </li>
		  <li class="row" style="display: flex; margin-bottom: 5px">
			  <a aria-label="4 star (86%)" class="a-size-small a-link-normal 5star col-md-3" title="5 star" href="" style="padding-left: 15px; padding-right: 0; ">4 star</a>
			  <div class="progress col-md 4" style="width:40%; margin: 0; ">
				  <div class="progress-bar" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width:50%">
					  <span class="sr-only">50% Complete</span>
				  </div>
			  </div>
			  <a class="a-size-base a-link-normal 5star histogram-review-count a-color-secondary col-md-3" tabindex="-1" href="" style="" >50%</a>
		  </li>
		  <li class="row" style="display: flex; margin-bottom: 5px">
			  <a aria-label="3 star (86%)" class="a-size-small a-link-normal 5star col-md-3" title="5 star" href="" style="padding-left: 15px; padding-right: 0; ">3 star</a>
			  <div class="progress col-md 4" style="width:40%; margin: 0; ">
				  <div class="progress-bar" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width:30%">
					  <span class="sr-only">30% Complete</span>
				  </div>
			  </div>
			  <a class="a-size-base a-link-normal 5star histogram-review-count a-color-secondary col-md-3" tabindex="-1" href="" style="" >30%</a>
		  </li>
		  <li class="row" style="display: flex; margin-bottom: 5px">
			  <a aria-label="2 star (86%)" class="a-size-small a-link-normal 5star col-md-3" title="5 star" href="" style="padding-left: 15px; padding-right: 0; ">2 star</a>
			  <div class="progress col-md 4" style="width:40%; margin: 0; ">
				  <div class="progress-bar" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width:60%">
					  <span class="sr-only">60% Complete</span>
				  </div>
			  </div>
			  <a class="a-size-base a-link-normal 5star histogram-review-count a-color-secondary col-md-3" tabindex="-1" href="" style="" >60%</a>
		  </li><li class="row" style="display: flex; margin-bottom: 5px">
		  <a aria-label="1 star (86%)" class="a-size-small a-link-normal 5star col-md-3" title="5 star" href="" style="padding-left: 15px; padding-right: 0; ">1 star</a>
		  <div class="progress col-md 4" style="width:40%; margin: 0; ">
			  <div class="progress-bar" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width:40%">
				  <span class="sr-only">40% Complete</span>
			  </div>
		  </div>
		  <a class="a-size-base a-link-normal 5star histogram-review-count a-color-secondary col-md-3" tabindex="-1" href="" style="" >40%</a>
	  </li>

	  </ul>
  </div>
</div>

									<div class="col-md-6">
									<c:if test="${reviews!=null}">
										<c:forEach items="${reviews}" var="review" varStatus="status">
											  <c:if test="${review.rating > 0}">
											    <p>
											    <div class="stars" id="productRating<c:out value="${status.count}"/>" style="width: 100px;">
											    </div>
											    <br/>
											    <blockquote>
    												<p><c:out value="${review.description}" escapeXml="false" /></p>
    												<small><c:out value="${review.customer.firstName}" />&nbsp;<c:out value="${review.customer.lastName}"/>&nbsp;<c:out value="${rating.date}"/>&nbsp;<c:out value="${review.date}" /></small>
   	 											</blockquote>
   	 											</p>
   	 											<script>
												  	$(function() {
														$('#productRating<c:out value="${status.count}"/>').raty({
															readOnly: true,
															half: true,
															path : '<c:url value="/resources/img/stars/"/>',
															score: <c:out value="${review.rating}" />
														});
												  	});
								  			   </script>
											  </c:if>
										</c:forEach>
								 	 </c:if>
									</div>
</div>

<script>
    $(function() {
        $('#averageRating').raty({
            readOnly: true,
            half: true,
            path : '<c:url value="/resources/img/stars/"/>',
            score: <c:out value="${4.90}" />
        });
    });
</script>