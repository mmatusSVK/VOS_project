/**
 * Created by matus on 14.6.2015.
 */

$(document).ready(function (e) {
    $('.dynamic_content').on("keyup", '.not_empty', function(){
        if($(this).val() == ""){
            $(this).val(1);
        }
    })
})