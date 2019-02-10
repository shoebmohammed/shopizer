<%@ page import="com.mysql.cj.api.Session" %>
<%
	response.setCharacterEncoding("UTF-8");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", -1);
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/shopizer-tags.tld" prefix="sm"%>

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<script src="<c:url value="/resources/js/jquery.elevateZoom-3.0.8.min.js" />"></script>
<script src="<c:url value="/resources/js/jquery.raty.min.js" />"></script>


<div id="shop" class="container-fluid">
	<!-- all-hyperion-page-start -->
	<div class="all-hyperion-page">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<!-- product-simple-area-start -->
					<div class="product-simple-area ptb-80 ptb-40-md ptb-20-xs" style="padding-top: 40px !important;">
						<div class="row">
							<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
								<div class="tab-content">
									<div class="tab-pane active" id="view1">
										<a class="image-link" href="${product.image.imageUrl}"><img src="${product.image.imageUrl}" alt=""></a>
									</div>
									<c:if test="${product.images!=null && fn:length(product.images) gt 1}">
										<c:forEach items="${product.images}" var="thumbnail">
											<c:if test="${thumbnail.imageType==0}">
												<div class="tab-pane" id="view<c:out value=" ${thumbnail.id}" />">
												<c:choose>
													<c:when test="${thumbnail.externalUrl==null}">
														<a href="<c:url value=" ${thumbnail.imageUrl}" />"
														class="image-link"
														imgId="im-
														<c:out value="${thumbnail.id}" />"
														title="
														<c:out value="${thumbnail.imageName}" />"
														rel="
														<c:url value="${thumbnail.imageUrl}" />"><img src="<c:url value=" ${thumbnail.imageUrl}" />"
														alt="
														<c:url value="${thumbnail.imageName}" />"></a>
													</c:when>
													<c:otherwise>
														<a href="javascript:;" " class=" detailsThumbImg thumbImg thumbnail image-link" imgId="im-<c:out value="
														 ${thumbnail.id}" />"
														title="
														<c:out value="${product.description.name}" />"
														rel="
														<c:url value="${thumbnail.externalUrl}" />"><img src="${thumbnail.externalUrl}" alt="<c:url value="
														 ${product.description.name}" />"></a>
													</c:otherwise>
												</c:choose>
								</div>
								</c:if>
								</c:forEach>
								</c:if>
							</div>
							<!-- Nav tabs -->
							<ul class="sinple-tab-menu" role="tablist">
								<c:if test="${product.images!=null && fn:length(product.images) gt 1}">
									<c:forEach items="${product.images}" var="thumbnail">
										<c:if test="${thumbnail.imageType==0}">
											<li><a href="#view<c:out value=" ${thumbnail.id}" />"
												data-toggle="tab"><img src="<c:url value=" ${thumbnail.imageUrl}" />"
												alt="
												<c:url value="${thumbnail.imageName}" />" /></a></li>
										</c:if>
									</c:forEach>
								</c:if>
							</ul>
						</div>
						<!-- fin col-lg -->
						<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12" style="height:70vh ; padding-left:40px;">
							<div class="product-simple-content">
								<div class="sinple-c-title">
									<h3 style="margin-bottom:0;">${product.description.name}</h3>
									<h4>${product.price}</h4>
									<div class="d-flex" style="width:100%; display:flex ; flex-wrap:wrap">
										<div class="product-price-star star-2" style="width:100% ; display: flex">
											<!-- Review -->
											<jsp:include page="/pages/shop/common/catalog/rating.jsp" />
										</div>

									</div>
									<hr style="margin-top:0;">
								</div>
								<div style="height:60%;">
									<div class="checkbox">
										<span>
											<c:if test="${not product.productVirtual}">
												<div class="checkbox">
													<!-- availability -->
													<p style="color:grey; font-size:13px; margin-bottom:2px; margin-left:20px; height:12px;">
														<s:message code="label.product" text="Availability" />:&nbsp;<span>
															<c:choose>
																<c:when test="${product.quantity>0}">
																	<span itemprop="availability" content="in_stock">${product.quantity}</span>
																</c:when>
																<c:otherwise>
																	<span itemprop="availability" content="out_of_stock">
																		<s:message code="label.product.outofstock" text="Out of stock" />
																</c:otherwise>
															</c:choose>
														</span><br></p>
												</div>
											</c:if>
										</span>
									</div>
									<!-- sku-->
									<p style="color:grey; margin-left:20px; font-size:13px; margin-bottom:2px; height:12px;	">
										<span>
											<s:message code="label.product.code" text="Product code" /> ${product.sku}
										</span></p>

									<!-- price -->
									<p>
										<span itemprop="offerDetails" itemscope itemtype="http://data-vocabulary.org/Offer">
											<meta itemprop="seller" content="${requestScope.MERCHANT_STORE.storename}" />
											<meta itemprop="currency" content="<c:out value=" ${requestScope.MERCHANT_STORE.currency.code}" />" />
											<p style="color:grey; margin-left:20px; font-size:13px;"><span id="productPrice" class="price">Price :
													<c:choose>
														<c:when test="${product.discounted}">

															<del>
																<c:out value="${product.originalPrice}" />
															</del>&nbsp;<span class="specialPrice"><span itemprop="price">
																	<c:out value="${product.finalPrice}" /></span></span>
														</c:when>
														<c:otherwise>
															<span itemprop="price">
																<c:out value="${product.finalPrice}" /></span>
														</c:otherwise>
													</c:choose>
												</span></p>
										</span>
									</p>
									<jsp:include page="/pages/shop/common/catalog/addToCartProduct.jsp" />
									<jsp:include
										page="/pages/shop/common/catalog/addToWishListProduct.jsp" />
									<button class="btn btn-basic" onclick="addToCompare('${product.id}')" style="margin-top: 10px;">
                      Add to Compare
                  </button>
									<br>
                  <jsp:include page="/pages/shop/common/compare/compare.jsp" />

									<div class="action-heiper">
										<iframe src="https://www.facebook.com/plugins/share_button.php?locale=${LOCALE.language}_${LOCALE.country}&href=<c:out value="
										 ${requestScope.CONFIGS['SHOP_SCHEME']}" />%3A%2F%2F
										<c:out value="${requestScope.MERCHANT_STORE.domainName}" />
										<c:url value="/shop/${product.description.friendlyUrl}.html" />&layout=button_count&size=large&mobile_iframe=true&appId=
										<c:out value="${requestScope.CONFIGS['shopizer.facebook-appid']}" />&width=83&height=28"
										width="100" height="28" style="border: none; overflow: hidden"
										scrolling="no" frameborder="0" allowTransparency="true"></iframe>
									</div>
								</div>
							</div>

						</div>
						<div class="col-md-3" style="height:auto; margin-left:60px;">
							<div class="exchange-button" style="width:80%; height:50px; margin-top:20px; margin-left:20px;">
								<button class="btn" style="width:100%; height:100%; background:#2E2D25; color:white">Exchange</button>

							</div>
							<div class="exchange-info" style="width:80%; height:200px; border:1px solid grey; margin-left:20px;">
								<lable style="margin-left:10px;">itemName : </lable>
								<select class="browser-default custom-select" style="margin-left:20px; margin-top:10px;">
									<option selected>Open this select menu</option>
									<option value="1">Computerbooks</option>
									<option value="2">sciencebooks</option>
									<option value="3">mobiles</option>
								</select>
							</div>


						</div>
					</div>
				</div>

				<!-- Q&A section -->
							<jsp:include page="/pages/shop/common/catalog/questionAndAnswer.jsp" />
							<br><br>


				<!-- product-simple-area-end -->
				<div class="product-info-detailed pb-80 ptb-40-md ptb-20-xs">
					<div class="row">
						<div class="col-lg-12">
							<div class="product-info-tab">
								<!-- Nav tabs -->
								<ul class="product-info-tab-menu" role="tablist">
									<li class="active"><a href="#details" data-toggle="tab"><i class="fa fa-file-text-o pr-5"></i>
											<s:message code="label.productedit.productdesc" text="Product description" /></a></li>
									<li><a href="#reviews" data-toggle="tab"><i class="fa fa-star pr-5"></i>
											<s:message code="label.product.customer.reviews" text="Customer reviews" /></a></li>
								</ul>
								<!-- Tab panes -->
								<div class="tab-content">
									<div class="tab-pane active" id="details">
										<div class="product-info-tab-content">
											<c:out value="${product.description.description}" escapeXml="false" />

											<dl class="dl-horizontal">
												<dt>
													<s:message code="label.product.weight" text="Weight" />
													:
												</dt>
												<dd>
													<fmt:formatNumber value="${product.productWeight}" maxFractionDigits="2" />
													&nbsp;
													<s:message code="label.generic.weightunit.${requestScope.MERCHANT_STORE.weightunitcode}" text="Pounds" />
												</dd>
												<dt>
													<s:message code="label.product.height" text="Height" />
													:
												</dt>
												<dd>
													<fmt:formatNumber value="${product.productHeight}" maxFractionDigits="2" />
													&nbsp;
													<s:message code="label.generic.sizeunit.${requestScope.MERCHANT_STORE.seizeunitcode}" text="Inches" />
												</dd>
												<dt>
													<s:message code="label.product.width" text="Width" />
													:
												</dt>
												<dd>
													<fmt:formatNumber value="${product.productWidth}" maxFractionDigits="2" />
													&nbsp;
													<s:message code="label.generic.sizeunit.${requestScope.MERCHANT_STORE.seizeunitcode}" text="Inches" />
												</dd>
												<dt>
													<s:message code="label.product.length" text="Length" />
													:
												</dt>
												<dd>
													<fmt:formatNumber value="${product.productLength}" maxFractionDigits="2" />
													&nbsp;
													<s:message code="label.generic.sizeunit.${requestScope.MERCHANT_STORE.seizeunitcode}" text="Inches" />
												</dd>
											</dl>
										</div>
									</div>
									<div class="tab-pane" id="reviews">
										<div class="customer-review-top">
											<h4>
												<s:message code="label.product.customer.reviews" text="Customer reviews" />
											</h4>
											<!-- reviews -->
											<jsp:include page="/pages/shop/common/catalog/reviews.jsp" />
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- fin product info -->
					</div>
					<!--fin col 9 -->
				</div>
			</div>

			<!-- Related items -->

			<div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
				<c:if test="${relatedProducts!=null}">
					<div class="feature-preduct-area hyperion home-page-2 pb-50 pb-50-md" style="padding-top: 40px !important;padding-bottom:10px !important;">
						<div class="row">
							<div class="col-lg-12">
								<div class="hyper-title">
									<h4 class="text-uppercase">
										<s:message code="label.product.related.title" text="Related items" />
									</h4>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-lg-12">
								<div>
									<div>
										<!-- Iterate over featuredItems -->
										<c:set var="ITEMS" value="${relatedProducts}" scope="request" />
										<jsp:include page="/pages/shop/templates/generic/sections/productBox.jsp" />
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:if>
				<c:if test="${requestScope.CONTENT['sideBar']!=null}">
					<sm:pageContent contentCode="sideBar" />
				</c:if>
			</div>
		</div>

		<!-- alex>>> -->
		<div id="most-viewed" class="row">
			<div class="col-xs-3">
				<a href="#" class="thumbnail">
      		<img src="../../../../../resources/img/index.jpeg" alt="...">
    		</a>
				<div>Some bullshit written by Alex</div>
			</div>
			<div class="col-xs-3">
				<a href="#" class="thumbnail">
      		<img src="../../../../../resources/img/index.jpeg" alt="...">
    		</a>
				<div>Some more bullshit written by Alex</div>
			</div>
			<div class="col-xs-3">
				<a href="#" class="thumbnail">
      		<img src="../../../../../resources/img/index.jpeg" alt="...">
    		</a>
				<div>Another bullshit written by Alex</div>
			</div>
			<div class="col-xs-3">
				<a href="#" class="thumbnail">
      		<img src="../../../../../resources/img/index.jpeg" alt="...">
    		</a>
				<div>And more bullshit written by Alex</div>
			</div>
		</div>
		<!-- alex<<< -->
	</div>
</div>
</div>
</div>
</div>

<script>

	$(function () {

		$('.popup-img').magnificPopup({ type: 'image' });


		$('.thumbImg').click(function () {
			var igId = $(this).attr('imgId');
			var url = $(this).attr('rel');
			var name = $(this).attr('title');
			$("#largeImg").html("<img src='" + url + "' /><a href='" + url + "' data-mfp-src='" + url + "' class='popup-img overlay' title='" + name + "'><i class='fa fa-search-plus'></i></a>");
			//re bind action
			$('.popup-img').magnificPopup({ type: 'image' });
		})

	})


	// function makeRequest(a) {
	//
	// 	var xmlHttpRequest = getXMLHttpRequest();
	// 	xmlHttpRequest.open("GET", "ChannelList?serverName=" + a, true);
	// 	xmlHttpRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	//
	// 	xmlHttpRequest.onreadystatechange = function () {
	// 		if (xmlHttpRequest.readyState == 4 && xmlHttpRequest.status == 200) {
	// 			alert(xmlHttpRequest.responseText);
	// 		}
	// 	}
	// 	xmlHttpRequest.send();
	// }


		function addToCompare(productId)
		{
				var product1 = sessionStorage.getItem('product1');
				var product2 = sessionStorage.getItem('product2');
				console.log(product1);
				console.log(product2);
				if(product1 === null){
					sessionStorage.setItem('product1',productId);
					alert('product added to compare list click compare list to see the product');
				} else if(product1 === productId) {
					alert('you already have this item in compare list');
				} else if(product2 === null) {
					sessionStorage.setItem('product2',productId);
                    alert('product added to compare list click compare list to see the product');
				} else if(product2 === productId){
					alert('you already have this item in compare list');
				} else {
					alert('you already have 2 items in compare list');
				}
		}
		</script>

</script>
