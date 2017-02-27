/*
        JFB VALIDATE ALL ALLOWED DIRECTIVE

        This directive allows anything in the field, including empty field.
        This directive is for optional fields where all is allowed.

        This directive have no extra inline params.
 */

jfbValidate.directive('jfbValidateAllAllowed', ['jfbValidate', function(jfbValidate) {

    return {

        link: function (scope, element, attrs) {

            // VALIDATE CONDITION:
            var validate_condition = function() { return true; };

            // CALL CONFIG DIRECTIVE...
            jfbValidate.configDirective(element, attrs, validate_condition, '');
        }
    }
}]);