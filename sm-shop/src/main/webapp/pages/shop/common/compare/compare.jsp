<%--
  Created by IntelliJ IDEA.
  User: sharath
  Date: 6/2/19
  Time: 12:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="/WEB-INF/shopizer-tags.tld" prefix="sm"%>

<style>
    table,td,tr,th{
        padding:5px;
    }
    table{
        width:1000px;
        margin: 10px;
        border-radius: 5px;
        margin-left: auto;
        margin-right: auto;
    }
    .remove{
        width:20px;
        height: 20px;
        padding: 0px;
    }
    #product1{
        width: 450px;
        padding: 10px;
    }
    #product2{
        width: 450px;
        padding: 10px;
    }
    .remove{
        z-index: 1;
        float: right;
    }
    #button-1{
        margin-top: 10px;
        margin-bottom: 10px;
    }
    #compare-list{
        border: 1px solid black;
        border-radius: 5px;
        background-color: white;
        display: none;
        width:75%;
        position: fixed;
        left: 50%;
        top: 50%;
        transform: translate(-50%,-50%);
        font-family: Arial, Baskerville, monospace;
    }
</style>
<button class="btn btn-basic" id="button-1">Compare List</button><br>
<div id="compare-list">
    <table class="responsive" border="1px solid black">
        <thead>
        <tr>
            <th>Properties</th>
            <th>Product 1</th>
            <th>Product 2</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>
                <p></p>
                <p><strong>ID</strong></p>
                <p><strong>Name</strong></p>
                <p><strong>Price</strong></p>
                <p><strong>Height</strong></p>
                <p><strong>Length</strong></p>
                <p><strong>Width</strong></p>
            </td>
            <td>
                <div id="product1">
                    <p>EMPTY</p>
                </div>
            </td>
            <td>
                <div id="product2">
                    <p>EMPTY</p>
                </div>
            </td>
        </tr>
        </tbody>
    </table>
    <button class="btn btn-basic" id="button-2">Close</button>
    <button class="btn btn-basic" id="button-3">Clear</button>
</div>
<script>
    $(document).ready(function() {
       $('#button-1').click(function () {
           if ( $( "#compare-list:first" ).is( ":hidden" ) ) {
               $( "#compare-list" ).slideDown( "slow" );
           } else {
               $( "#compare-list" ).slideUp("slow");
           }
       });
       $('#button-2').click(function () {
           $( "#compare-list" ).slideUp( "slow" );
       });
       $('#button-3').click(function () {
           clearCompareList();
       });
    });
    function showCompareList() {
        var compareList = document.getElementById('compare-list');
        compareList.style.display = 'inline'
    }
    function closeCompareList() {
        var compareList = document.getElementById('compare-list');
        compareList.style.display = 'none'
    }
    function removeItem(div) {
        document.getElementById(div).innerHTML='<p>EMPTY</p>';
        sessionStorage.removeItem(div);
    }
    function clearCompareList() {
        document.getElementById('product1').innerHTML='<p>EMPTY</p>';
        document.getElementById('product2').innerHTML='<p>EMPTY</p>';
        sessionStorage.removeItem('product1');
        sessionStorage.removeItem('product2');
    }
    var product1 = null;
    var product2 = null;
    setInterval(function () {
        var oldProduct1 = product1;
        var oldProduct2 = product2;
        product1 = sessionStorage.getItem('product1');
        product2 = sessionStorage.getItem('product2');
        var contentOfProduct1=null;
        var contentOfProduct2=null;
        if(product1 !== null && oldProduct1 !== product1){
            $.get('http://localhost:8080/api/v1/products/'+product1,function (data) {
                console.log(data);
                contentOfProduct1 = "<button class='btn btn-basic remove' onclick=\"removeItem('product1')\">X</button><br><div id='content'>"
                    +"<p>"+data.id+"</p>"
                    +"<p>"+data.description.name+"</p>"
                    +"<p>"+data.originalPrice+"</p>"
                    +"<p>"+data.productHeight+" inches</p>"
                    +"<p>"+data.productLength+" inches</p>"
                    +"<p>"+data.productWidth+" inches</p>"+
                    "</div>";
                $('#product1').html(contentOfProduct1);
            });
        }
        if(product2 !== null && oldProduct2 !== product2){
            $.get('http://localhost:8080/api/v1/products/'+product2,function (data) {
                console.log(data);
                contentOfProduct2 = "<button class='btn btn-basic remove' onclick=\"removeItem('product2')\">X</button><br><div id='content'>"
                    +"<p>"+data.id+"</p>"
                    +"<p>"+data.description.name+"</p>"
                    +"<p>"+data.originalPrice+"</p>"
                    +"<p>"+data.productHeight+" inches</p>"
                    +"<p>"+data.productLength+" inches</p>"
                    +"<p>"+data.productWidth+" inches</p>"+
                    "</div>";
                $('#product2').html(contentOfProduct2);
            });
            document.getElementById('product2').innerHTML = contentOfProduct2;
        }
    },1000);
</script>