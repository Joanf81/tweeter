/*
        JFB VALIDATE NUMBERS LETTERS DIRECTIVE

        This directive validate that the content of the field where it's used can only contain letters, numbers, or both.
        Space character is not allowed.
        If the field is empty, it won't produce the validation alert.

        This directive allow this extra inline params:

            - jfb-validate-numbers-letters-message -> A string that contains the alert description text
                    showed in the message box. IMPORTANT: If this param is not set the message box will
                    contain the default message specified below, if this is set to empty string the message
                    box will be showed but with no message.
 */

jfbValidate.directive('jfbValidateNumbersLetters', ['jfbValidate', function(jfbValidate) {

    return {

        link: function (scope, element, attrs) {

            // DEFAULT MESSAGE FOR THIS ALERT:
            var default_alert_message = "This field can only contain letters, numbers, or both."


            // INLINE ARGUMENTS:
            if (attrs.jfbValidateNumbersLettersMessage != null) {

                var text_message_box = attrs.jfbValidateNumbersLettersMessage;

            } else var text_message_box = default_alert_message;


            // VALIDATE CONDITION:
            var validate_condition = function(element_content) {

                if (element_content.length == 0) {

                    return true;

                } else {

                    if (/^[0-9a-zA-Z]+$/.test(element_content)) {

                        return true;

                    } else return false;
                }
            };


            // CALL CONFIG DIRECTIVE...
            jfbValidate.configDirective(element, attrs, validate_condition, text_message_box);
        }
    }
}]);