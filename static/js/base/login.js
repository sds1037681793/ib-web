/**
 * 调用js
 * 2016-3-17
 */
/**
 * login
 */
$(function(){
    
    var checkbox = $('input[type="checkbox"]');
    checkbox.on("click", function(){
        
        var _this = $(this),
        _thisblock = _this.next('i');

        if(_this.is(':checked')){
            _thisblock.addClass("checked");
        }else{
            _thisblock.removeClass("checked");
        }
        
    });
    $.ajax({
        type: "post",
        url: ctx + "/network/index?CHECK_AUTHENTICATION=false&locationUrl=" + locationUrl,
        dataType: "json",
        contentType: "application/json;charset=utf-8",
        success:function(data) {
        },
        error: function(req,error,errObj) {
            return false;       
        }
    });
});
