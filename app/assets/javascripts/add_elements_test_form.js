/**
 * Created by matus on 19.4.2015.
 */

$(document).ready(function (){

        $('a#add-another').click(function() {
            $(".dynamic_content li:first").clone().find('input')
                .end().appendTo('.dynamic_content')
        });
        $('.delete-current').on('click' ,function() {
            if ($('.dynamic_content li').length > 1)
                $(".dynamic_content li:last").remove();
            else
                alert('Test sa musí skladať aspoň z otázok jednej témy.');
        });
});


