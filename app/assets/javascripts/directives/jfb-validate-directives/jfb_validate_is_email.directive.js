/*
        JFB VALIDATE IS EMAIL DIRECTIVE

        This directive validate that the content of the field where it's used has a email format.
        (Valid: hello@email.com, Invalid: hello.com, hello@email, hello@aa@add.com, ...)
        If the field is empty, it won't produce the validation alert.

        This directive allow this extra inline params:

            - jfb-validate-is-email-message -> A string that contains the alert description text
                    showed in the message box. IMPORTANT: If this param is not set the message box will
                    contain the default message specified below, if this is set to empty string the message
                    box will be showed but with no message.
 */

jfbValidate.directive('jfbValidateIsEmail', ['jfbValidate', function(jfbValidate) {

    return {

        link: function (scope, element, attrs) {

            // DEFAULT MESSAGE FOR THIS ALERT:
            var default_alert_message = "This field must be a valid email."


            // INLINE ARGUMENTS:
            if (attrs.jfbValidateIsEmailMessage != null) {

                var text_message_box = attrs.jfbValidateIsEmailMessage;

            } else var text_message_box = default_alert_message;


            // VALIDATE CONDITION:
            var validate_condition = function(element_content) {

                if (element_content.length == 0) {

                    return true;

                } else {

                    if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(element_content)) {

                        return true;

                    } else return false;
                }
            };


            // CALL CONFIG DIRECTIVE...
            jfbValidate.configDirective(element, attrs, validate_condition, text_message_box);
        }
    }
}]);