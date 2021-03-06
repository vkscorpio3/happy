<dsp:page>

  <dsp:importbean bean="/com/castorama/CastShoppingCartFormHandler"/>
  <dsp:importbean bean="/atg/commerce/catalog/ProductLookup"/>
  <dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
  <dsp:importbean bean="/atg/dynamo/droplet/For"/>
  <dsp:importbean bean="/atg/commerce/catalog/CategoryLookup"/>
  <dsp:importbean bean="/com/castorama/droplet/StyleLookupDroplet"/>
  <dsp:importbean bean="/atg/commerce/pricing/priceLists/PriceDroplet"/>
  <dsp:importbean bean="/atg/targeting/TargetingFirst"/>
  <dsp:importbean bean="/com/castorama/droplet/IsRobotDroplet"/>
  <dsp:importbean bean="/com/castorama/droplet/CastLookupDroplet"/>
  <dsp:importbean bean="/com/castorama/search/droplet/CastCarouselSearchDroplet"/>
  <dsp:importbean bean="/com/castorama/CastPriceRangeDroplet"/>
  <dsp:importbean bean="/com/castorama/CastConfiguration"/>

  <dsp:getvalueof var="carouselProductCount" bean="CastConfiguration.carouselProductsCount"/>

  <dsp:getvalueof var="ownerCategoryId" param="ownerCategoryId"/>
  <dsp:getvalueof var="ownerProductId" param="ownerProductId"/>
  <dsp:getvalueof var="isSearchResult" param="isSearchResult"/>

  <dsp:getvalueof var="contextPath" bean="/OriginatingRequest.contextPath"/>
  <dsp:getvalueof var="requestURI" bean="/OriginatingRequest.requestURI"/>
  <dsp:getvalueof var="pivotCategoryId" param="categoryId"/>
  <dsp:getvalueof var="productId" param="productId"/>
  <dsp:getvalueof var="trailVar" bean="/com/castorama/carousel/CarouselSessionBean.values.facetedSearchQueryString"/>
  <dsp:getvalueof var="isRobot" value="false"/>
  <dsp:getvalueof var="sortByValue" param="sortByValue"/>
  <c:choose>
   <c:when test="${sortByValue == 'lowHighPrice'}">
     <c:set var="docSortMode" value="numprop"/>
     <c:set var="docSortOrder" value="ascending"/>
     <c:set var="docSortProp" value="price"/>
   </c:when>
   <c:when test="${sortByValue == 'highLowPrice'}">
     <c:set var="docSortMode" value="numprop"/>
     <c:set var="docSortOrder" value="descending"/>
     <c:set var="docSortProp" value="price"/>
   </c:when>
   <c:otherwise>
     <c:set var="docSortMode" value="relevance"/>    
   </c:otherwise>
  </c:choose>
  <dsp:droplet name="IsRobotDroplet">
    <dsp:oparam name="true">
      <dsp:getvalueof var="isRobot" value="true"/>
    </dsp:oparam>
  </dsp:droplet>

  <c:if test="${not empty trailVar}">
    <dsp:getvalueof var="trailParam" value="trail=" vartype="java.lang.String"/>
    <dsp:getvalueof var="trailIndex" value="${fn:indexOf(trailVar, trailParam)}"/>
    <c:if test="${trailIndex > -1}">
      <dsp:getvalueof var="trailVar" value="${fn:substringAfter(trailVar, trailParam)}"/>
      <dsp:getvalueof var="paramSep" value="&"/>
      <dsp:getvalueof var="trailVar" value="${fn:substringBefore(trailVar, paramSep)}"/>
    </c:if>
  </c:if>

  <c:if test="${empty pivotCategoryId}">
    <dsp:getvalueof var="pivotCategoryId" value="NOPIVOT" />
  </c:if>  
  <c:if test="${empty trailVar}">
    <dsp:getvalueof var="trailVar" value="NOTRAIL" />
  </c:if>  

  <dsp:droplet name="TargetingFirst">
    <dsp:param name="howMany" value="1"/>
    <dsp:param name="fireViewItemEvent" value="false"/>
    <dsp:param name="targeter" bean="/atg/registry/RepositoryTargeters/RefinementRepository/CategoryFacetTargeter"/>
    <dsp:oparam name="output">
      <dsp:getvalueof var="categoryFacetId" param="element.repositoryId" />
    </dsp:oparam>
  </dsp:droplet>

  <dsp:droplet name="CastLookupDroplet">
    <dsp:param name="id" param="documentId"/>
    <dsp:param name="elementName" value="document"/>
    <dsp:param name="itemDescriptor" value="castoramaDocument"/>
    <dsp:param name="repository" bean="/atg/commerce/catalog/ProductCatalog"/>
    <dsp:oparam name="output">
      <dsp:getvalueof var="document" param="document"/>
    </dsp:oparam>
  </dsp:droplet>

  <dsp:droplet name="CastCarouselSearchDroplet">
    <dsp:param name="pivotCategoryId" param="categoryId"/>
    <dsp:param name="productId" param="productId"/>
    <dsp:param name="categoryFacetId" value="${categoryFacetId}"/>
    <dsp:param name="document" value="${document}" />
    <dsp:param name="cacheCheckSeconds" bean="CastConfiguration.cacheCheckSeconds" />
    <dsp:param name="docSortMode" value="${docSortMode}"/>
    <dsp:param name="docSortOrder" value="${docSortOrder}" />
    <dsp:param name="docSortProp" value="${docSortProp}" />
    <dsp:oparam name="output">
    </dsp:oparam>
  </dsp:droplet>

  <dsp:getvalueof var="foundProductIds" bean="/com/castorama/carousel/CarouselSessionBean.values.foundProductIds"/>

  <c:set var="foundProductAmount" value="${fn:length(foundProductIds)}"/>
  <c:if test="${foundProductAmount > 1}">
  
      <dsp:droplet name="/com/castorama/droplet/MultiStockVisAvailabilityDroplet">
	    <dsp:param name="productsIds" value="${foundProductIds}" />
	    <dsp:param name="store" bean="/atg/userprofiling/Profile.currentLocalStore" />
	    <dsp:oparam name="output">
	      <c:choose>
	      <c:when test="${empty svAvailableMap}">
	        <dsp:getvalueof var="svAvailableMap" param="svAvailableMap" scope="request"/>
	      </c:when>
	      <c:otherwise>
	        <dsp:getvalueof var="addToSvAvailableMap" param="svAvailableMap" />
	        ${castCollection:putAll(svAvailableMap, addToSvAvailableMap)}
	      </c:otherwise>
	      </c:choose>
	    </dsp:oparam>
	  </dsp:droplet>
  
    <fmt:message key="search_searchPaging.next" var="next"/>
    <fmt:message key="search_searchPaging.precedent" var="previous"/>
    <c:if test="${foundProductAmount>10}">
      <div class="carPrev">
        <a href="javascript:void(0)" title="${previous}">${previous}</a>
      </div>
    </c:if>

    <c:choose>
      <c:when test="${foundProductAmount<=10}">
        <div class="carThumbs fWidthCarousel">
      </c:when>
      <c:otherwise>
        <div class="carThumbs">
      </c:otherwise>
    </c:choose>

    <ul width="170px;">
      <dsp:droplet name="ForEach">
        <dsp:param name="array" value="${foundProductIds}"/>
        <dsp:param name="elementName" value="productId"/>
        <dsp:oparam name="output">
          <dsp:droplet name="ProductLookup">
            <dsp:param name="id" param="productId"/>
            <dsp:param name="elementName" value="product"/>
            <dsp:oparam name="output">
              <dsp:droplet name="CastPriceRangeDroplet">
                <dsp:param name="productId" param="productId"/>
                <dsp:oparam name="output">
                  <dsp:getvalueof var="notCheapestSkuPromo" param="notCheapestSkuPromo"/>
                  <dsp:getvalueof var="index" param="index"/>
                  <c:if test="${index<carouselProductCount}">
                    <li>
                      <dsp:getvalueof var="childSku" param="product.childSKUs"/>
                      <dsp:getvalueof var="productId" param="product.repositoryId"/>
    
                      <dsp:getvalueof var="categoryId" param="product.parentCategory.id"/>
                      <dsp:getvalueof var="ownerProductId" param="ownerProductId"/>
                      <dsp:getvalueof var="isRobot" value="false"/>
                      <dsp:getvalueof var="name" param="product.displayName"/>
                      <dsp:getvalueof var="carouselImage" param="sku.carouselImage.url"/>
                      <!-- !!!<dsp:getvalueof var="templateUrl" param="product.template.url"/>  -->
                      <dsp:droplet name="/com/castorama/droplet/CastProductLinkDroplet">
                        <dsp:param name="productId" value="${productId}"/>
                        <dsp:param name="navAction" value="push"/>
                        <dsp:param name="navCount" bean="/atg/commerce/catalog/CatalogNavHistory.navCount"/>
                        <dsp:param name="isSearchResult" value="${isSearchResult}"/>
                        <dsp:param name="sortByValue" param="sortByValue"/>
                        <dsp:param name="ba" value="${baFakeContext}"/>
                        <dsp:param name="hideBreadcrumbs" value="${bonnesAffaires}"/>
                        <dsp:oparam name="output">
                          <dsp:getvalueof var="templateUrl" param="url"/>
                        </dsp:oparam>
                      </dsp:droplet>
                      <a href="${contextPath}${templateUrl}" title="${name}">
                        <c:choose>
                          <c:when test="${not empty carouselImage}">
                            <img src="${carouselImage}" alt="${name}"/>
                          </c:when>
                          <c:otherwise>
                            <img src="/default_images/b_no_img.jpg" alt="${name}"/>
                          </c:otherwise>
                        </c:choose>   
                        <c:if test="${ownerProductId==productId}">
                          <c:choose>
                            <c:when test="${isSearchResult}">
                              <dsp:getvalueof var="borderColor" param="product.parentCategory.style.borderStyle" />
                            </c:when>
                            <c:otherwise>
                              <dsp:droplet name="StyleLookupDroplet">
                                <dsp:param name="categoryId" value="${ownerCategoryId}" />
                                <dsp:oparam name="output">
                                  <dsp:getvalueof var="borderColor" param="style.borderStyle"/>
                                </dsp:oparam>
                              </dsp:droplet>
                            </c:otherwise>
                          </c:choose>
                          <div class="cImBorder ${borderColor }"><!--~--></div>
                        </c:if>
                      </a>
                      <div class="lImage">
                        <div class="hasHighlight">
                          <dsp:include page="prodHighlight.jsp">
                            <dsp:param name="product" param="product"/>
                            <dsp:param name="notCheapestSkuPromo" value="${notCheapestSkuPromo}"/>
                            <dsp:param name="viewProduct" value="true"/>
                            <dsp:param name="categoryId" value="${categoryId}"/>
                            <dsp:param name="view" value="galeryView"/>
                          </dsp:include>
    
                          <div id="${productId}">
                            <dsp:droplet name="PriceDroplet">
                              <dsp:param name="sku" param="sku"/>
                              <dsp:oparam name="output">
                                <dsp:getvalueof var="thisPrice" param="price.listPrice"/>
                              </dsp:oparam>
                              <dsp:oparam name="empty">
                                <dsp:getvalueof var="thisPrice" value=""/>
                              </dsp:oparam>
                            </dsp:droplet>
                            <dsp:getvalueof var="productType" param="product.type"/>
                            <dsp:getvalueof var="isMultySKU" param="product.childSKUs"/>
                            <c:if test="${(productType=='casto-grouped-product') or ((not empty isMultySKU) and (fn:length(isMultySKU) > 1)) or (empty thisPrice)}">
                              <div id="undraggableProduct"><!--~--></div>
                            </c:if>
                            <dsp:getvalueof var="skuId" param="sku.repositoryId"/>
                            <dsp:getvalueof var="skuCodeArticle" param="sku.CodeArticle"/>
                            <dsp:getvalueof var="supportingImage" param="sku.supportingImage.url"/>
                            <dsp:a href="${contextPath}${templateUrl}">
                              <div class="image">
                              <c:choose>
                                <c:when test="${productType=='casto-grouped-product'}">
                                      <%@ include file="/shoppingList/includes/groupedProductInfo.jspf"%>
                                      <c:choose>
                                        <c:when test="${not empty supportingImage}">
                                          <img class="draggableImage" id="${skuList}" src="${supportingImage}" srcList="${imgSrcList}" prodList="${productList}" alt="${namesList}" skuCodeArticle="${skuCodeArticleList}" productId="${product.repositoryId}"/>
                                        </c:when>
                                        <c:otherwise>
                                          <img class="draggableImage" id="${skuList}" src="/default_images/d_no_img.jpg" srcList="${imgSrcList}" prodList="${productList}" alt="${namesList}" skuCodeArticle="${skuCodeArticleList}" productId="${product.repositoryId}"/>
                                        </c:otherwise>
                                       </c:choose>
                                 </c:when>                                
                                <c:otherwise>
                                  <c:choose>
                                    <c:when test="${not empty supportingImage}">
                                      <img class="draggableImage" src="${supportingImage}" alt="${name}" title="${name}"  id="${skuId}" productId="${productId}" skuCodeArticle="${skuCodeArticle }"/>
                                    </c:when>
                                    <c:otherwise>
                                      <img class="draggableImage" src="/default_images/d_no_img.jpg" alt="${name}" title="${name}"  id="${skuId}" productId="${productId}" skuCodeArticle="${skuCodeArticle }"/>
                                    </c:otherwise>
                                  </c:choose>
                                </c:otherwise>
                              </c:choose>
                              </div>
                              <div class="imgDesc"><c:out value="${name}" /></div>
                            </dsp:a>
                          </div>
                          <div class="priceSection">
                            <dsp:getvalueof var="skuId" param="sku.repositoryId"/>
                            <dsp:getvalueof var="storeId" bean="/atg/userprofiling/Profile.currentLocalStore.id"/>
                            <dsp:droplet name="/com/castorama/droplet/ProductPriceCache">
                              <dsp:param name="key" value="prod_price_${productId}_${skuId}_${isRobot}_${storeId}"/>
                              <dsp:param name="cacheCheckSeconds" bean="CastConfiguration.cacheCheckSeconds"/>
                              <dsp:oparam name="output">
                                <dsp:include page="skuPrice.jsp">
                                  <dsp:param name="pageType" value="carousel"/>
                                  <dsp:param name="productId" value="${productId}"/>
                                  <dsp:param name="sku" param="sku"/>
                                </dsp:include>
                              </dsp:oparam>
                            </dsp:droplet>
                          </div>
                        </div>
    
                        <div class="addToCartSection">
                          <dsp:include page="addToCartSmall.jsp">
                            <dsp:param name="sku" param="sku"/>
                            <dsp:param name="productId" value="${productId}"/>
                            <dsp:param name="childSku" value="${childSku}"/>
                            <dsp:param name="url" value="${contextPath}${templateUrl}"/>
                            <dsp:param name="showDeliveryMsg" value="false"/>
                          </dsp:include>
                        </div>
                      </div>
                    </li>
                  </c:if>
                </dsp:oparam>
              </dsp:droplet>    
            </dsp:oparam>
          </dsp:droplet>
        </dsp:oparam>
      </dsp:droplet>
    </ul>
    </div>
    <c:if test="${foundProductAmount>10}">
      <div class="carNext">
        <a href="javascript:void(0)" title="${next}">${next}</a>
      </div>
    </c:if>

    <div class="clear"></div>
    <div class="carouselPopup">
      <div class="inside prdMarker"><!--~--></div>
    </div>
  </c:if>

</dsp:page>