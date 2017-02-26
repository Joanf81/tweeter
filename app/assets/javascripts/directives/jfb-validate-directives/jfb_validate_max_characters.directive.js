/*
        JFB VALIDATE MAX CHARACTERS DIRECTIVE

        This directive validate that the field where it's used have a maximum number of characters.
        This directive allow this extra inline params:

            - jfb-validate-max-characters -> (Main param) Maximum number of characters that the field must contain.

            - jfb-validate-max-characters-message -> A string that contains the alert description text
                    showed in the message box. IMPORTANT: If this param is not set the message box will
                    contain the default message specified below, if this is set to empty string the message
                    box will be showed but with no message.
 */

jfbValidate.directive('jfbValidateMaxCharacters', ['jfbValidate', function(jfbValidate) {

    return {

        link: function (scope, element, attrs) {

            
            // MAIN ARGUMENT:
            if (attrs.jfbValidateMaxCharacters != null) {

                var max_characters = attrs.jfbValidateMaxCharacters;

            } else var max_characters = 0;


            // DEFAULT MESSAGE FOR THIS ALERT:
            var default_alert_message = "The maximum number of characters for this field is " + max_characters + ".";


            // INLINE ARGUMENTS:
            if (attrs.jfbValidateMaxCharactersMessage != null) {

                var text_message_box = attrs.jfbValidateMaxCharactersMessage;

            } else var text_message_box = default_alert_message;
            

            // VALIDATE CONDITION:
            var validate_condition = function(element_content) {

                return (element_content.length <= max_characters);
            };


            // CALL CONFIG DIRECTIVE...
            jfbValidate.configDirective(element, attrs, validate_condition, text_message_box);
        }
    }
}]);