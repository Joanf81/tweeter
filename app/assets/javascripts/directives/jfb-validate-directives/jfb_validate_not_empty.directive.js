/*
        JFB VALIDATE NOT EMPTY DIRECTIVE

        This directive validate that the field where it's used is not empty.
        This directive allow this extra inline params:

            - jfb-validate-not-empty-message -> A string that contains the alert description text
                    showed in the message box. IMPORTANT: If this param is not set the message box will
                    contain the default message specified below, if this is set to empty string the message
                    box will be showed but with no message.
 */

jfbValidate.directive('jfbValidateNotEmpty', ['jfbValidate', function(jfbValidate) {

    return {

        link: function (scope, element, attrs) {

            // DEFAULT MESSAGE FOR THIS ALERT:
            var default_alert_message = "This field can't be empty."


            // INLINE ARGUMENTS:
            if (attrs.jfbValidateNotEmptyMessage != null) {

                var text_message_box = attrs.jfbValidateNotEmptyMessage;

            } else var text_message_box = default_alert_message;


            // VALIDATE CONDITION:
            var validate_condition = function(element_content) {

                return (element_content != '');
            };


            // CALL CONFIG DIRECTIVE...
            jfbValidate.configDirective(element, attrs, validate_condition, text_message_box);
        }
    }
}]);