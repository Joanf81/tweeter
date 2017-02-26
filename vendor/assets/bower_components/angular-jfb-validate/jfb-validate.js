/*
 ANGULAR JFB VALIDATE V1.0.0

 A mini costumable framework to create angular directives for automaticing a visual and animated 
 validation of html inputs. When a input produces a validation error, then it will change
 its border color and it will show a animated message box describing the error.

 Many visual attributes can be costumiced bellow.

 Basic example of use:

 // app.js 
 var app = angular.module('app', ['jfb.validate'])
 .directive('example-validate-directive', ['jfbValidate', function(jfbValidate) {

    return {
        link: function (scope, element, attrs) {

            // DEFAULT MESSAGE FOR THIS ALERT:
            var default_alert_message = "A validation alert has been produced."

            // VALIDATE CONDITION:
            var validate_condition = function(element_content) {

                return (element_content != 'Hi World!');
            }

            // CALL CONFIG DIRECTIVE...
            jfbValidate.configDirective(element, attrs, validate_condition, text_message_box);
        }
    }
 }]);

 The configDirective function needs these arguments:

 - element & attrs -> Provided by the directive's link function.

 - validate_condition -> A function that receives one string param (the
 content of the element), and returns a boolean value (the result
 of the validate condition.

 - text_alert_box -> A string that contains the alert description text
 showed in the message box. IMPORTANT: If the param is set to null,
 then the alert box won't be showed.


 // index.html
 <body ng-app="app">
    <form>
        <input type="text" id="field" name="field" ng-model="field" example-validate-directive jfb-validate-content="{{field}}">
    </form>
    
    <!-- Angular lib -->
    <script src="ANGULAR_PATH/angular.js"></script>
    <!-- jQuery lib -->
    <script src="JQUERY_PATH/dist/jquery.min.js"></script>

    <script src="app.js">
 </body>

 A directive that uses this function will need to specify these inline params:
 (These params are common to all jfb validate directives used on the same element)

 - jfb-validate-content -> The string to validate. (*This attribute is necessary)

 - jfb-validate-alert-height --> The height of the message box (when it's showed)
 If this attribute is not assigned, the directive will use the default value
 assigned in the config file.


 Tested using...
    - Angular v1.6.1
    - JQuery v3.1.1

 Author:
 Joan Fernández Bornay
 http://github.com/joanf81
*/


var jfbValidate = angular.module('jfb.validate', [])

/*
 JFB VALIDATE CONFIGURATION SECTION:

 In this section is possible to modify the default aspect of the alerts showed by the
 directive, the changes in this file will affect to all of the jfb validate directives
 used in the application.

 IMPORTANT!
 YOU CAN EDIT THE VALUES OF THIS SECTION, but not the name of the values, for example:
 In the attribute 'border_size': '0.5px', you can change the 0.5px value but you
 can't change the border_size name.

 Enjoy! :)
 */
.constant('jfbValidateConfig', {

    /************* Configuration of the affected element **********/

    // The affected element's border will have this color when the alert is showed:
    'color_alert': 'rgb(255, 120, 100)', // Red

    // The affected element's border will have this color when his validation is ok:
    'color_validated': 'rgb(85, 211, 54)', // Green

    // The affected element's border will have this color when it's focused:
    'color_focused': 'rgb(76, 179, 223)', // Blue


    // The affected element's shadow border will have this size when it's marked with the previous colors:
    'border_shadow_size': '5px',


    // Duration of the border's color transition:
    'border_color_transition': '0.2s',

    // Duration of the border's shadow color transition:
    'border_shadow_color_transition': '0.5s',


    /************* Configuration of the message box **********/

    // Default height of the message box:
    // (If this value is not assigned in the directive's arguments, the directive will use
    // this default value)
    'height_message_box': '35px',

    // Border's width of the message box:
    'border_message_box': '1px',

    // Border's color of the message box:
    'border_color_message_box': 'rgb(255, 162, 147)',  // Red

    // Background's color of the message box:
    'background_color_message_box': 'rgb(255, 220, 214)',  // Red

    // Radius of the borders of message box. (0px is total square)
    'radius_message_box': '3px',

    // Top margin of the message box
    'top_margin_message_box': '2px',

    // Bottom margin of the message box:
    'bottom_margin_message_box': '5px',


    /************* Configuration of the text message **********/

    // Message marked between <b></b> on the alert box:
    // (This message is common in all of the validation messages)
    'strong_message': 'Validation alert!',

    // Font size of thee message:
    'message_font_size': '100%',

    // Font color of the message:
    'message_font_color': 'rgb(196, 50, 18)',  // Red

    // Font type of the message:
    'message_font': 'Arial, Helvetica, sans-serif',
    // Other example fonts:
    //'message_font':'Times New Roman, Times, serif',
    //'message_font':'Georgia, serif',
    //'message_font':''Lucida Console, Monaco, monospace'',
    // You can use too google fonts, but it's necesary to add the corresponding font link tag to the html file.
    // Google fonts, example of use: https://www.w3schools.com/howto/howto_google_fonts.asp


    /************* Configuration of the animations's duration of the message box **********/
    // IMPORTANT! Express it only in Milliseconds
    // (Put '0' in all of this attributes for use no transitions)

    // Duration of the animation for showing the message box:
    'message_box_show_transition_duration': '300',

    // Duration of the animation for hidding the message box:
    'message_box_hide_transition_duration': '300',
})


/*
 JFB VALIDATE ELEMENT:

 This service groups the function that affects the element where the jfb validate directive
 is used. It provides a function to config the transitions on the element, and another
 function to change the element's border color using the configured transitions.

 Do not modify.
 */
.factory('jfbValidateElement', ['jfbValidateConfig', function(jfbValidateConfig) {

    return {

        // Definition of the element's transition duration
        configElementTransitions: function(element) {

            element.css('transition-property', 'border-color, box-shadow');
            element.css('transition-duration', jfbValidateConfig.border_color_transition + ', ' + jfbValidateConfig.border_shadow_color_transition);
        },

        // Function to change the element's border color
        changeElementBorderColor: function(element, color) {

            element.css('border-color', color);
            element.css('box-shadow', '0 0 ' + jfbValidateConfig.border_shadow_size + ' ' + color);
        }
    };
}])


/*
 JFB VALIDATE MESSAGE BOX DESIGN:

 In this fservice, the design and the style of the alert box showed by the jfb validate
 directives is specified. Design using HTML, style using CSS.

 Do not modify.
 */
.factory('jfbValidateMessageBox', ['jfbValidateConfig', function(jfbValidateConfig) {

    return {

        // Creates an html+css code of the showed message box:
        getConfiguredMessageBox: function(alert_message) {

            // Configure the css of the text's message box:
            var text_message_box_style = 'display: table-cell;'
                + 'vertical-align: middle; '
                + 'color: ' + jfbValidateConfig.message_font_color + '; '
                + 'font-family: ' + jfbValidateConfig.message_font + '; '
                + 'padding-left: 5%; ';

            // Design of the teext of the message box
            var text_message_design = '<span style="' + text_message_box_style + '"> <strong>' + jfbValidateConfig.strong_message + '</strong>'
                + '&nbsp&nbsp&nbsp&nbsp' + alert_message + '</span>';

            // Configure the css of the alert's message box:
            var message_box_style = 'background-color: ' + jfbValidateConfig.background_color_message_box + '; '
                + 'border: 0px solid ' + jfbValidateConfig.border_color_message_box + '; '
                + 'border-radius: ' + jfbValidateConfig.radius_message_box + '; '
                + 'font-size: 0px; '
                + 'margin-top: 0px; '
                + 'margin-bottom: 0px; '
                + 'height: 0px; '
                + 'width: 100%; '
                + 'display: table;';

            // Design of the message box:
            var message_box_design = '<div style="' + message_box_style + '">'
                + text_message_design
                + '</div>';

            return message_box_design;
        }
    }
}])


/*
 JFB VALIDATE MESSAGE BOX ANIMATOR:

 This service provides a set of functions related with angular animations. One of these is a function that allows the
 element to show angular animations, the other functions are one for showing the message box using a angular
 animation and another for hiding it.

 Do not modify.
 */

.factory('jfbValidateMessageBoxAnimation', ['jfbValidateConfig', 'jfbValidateMessageBox',
    function(jfbValidateConfig, jfbValidateMessageBox) {

        return {

            // Function to show the alert message box
            showAlertMessageBox: function(element, height, text_message_box, callback) {

                // Add a hidden message box after the affected element                
                $(element).after(jfbValidateMessageBox.getConfiguredMessageBox(text_message_box));

                // Animate de message box to be showed:
                $(element).next().animate(
                    // Propieties to animate:
                    {   
                        'height': height,
                        'border-width': jfbValidateConfig.border_message_box,
                        'font-size': jfbValidateConfig.message_font_size,
                        'margin-top': jfbValidateConfig.top_margin_message_box,
                        'margin-bottom': jfbValidateConfig.bottom_margin_message_box
                    },
                    // Duration of the animation:
                    jfbValidateConfig.message_box_show_transition_duration,
                    // Easing fuction to use in transition:
                    'swing',
                    // Callback function. When the animation is finished, then launch the callback:
                    function() {
                        if (callback != null) callback();
                    }
                );
            },

            // Function to hide the alert message box
            hideAlertMessageBox: function(element, callback) {

                // Animate de message box to hide it:
                $(element).next().animate(
                    // Propieties to animate:
                    {   
                        'height': 0,
                        'border-width': 0,
                        'font-size': 0,
                        'margin-top': 0,
                        'margin-bottom': 0
                    },
                    // Duration of the animation:
                    jfbValidateConfig.message_box_hide_transition_duration,
                    // Easing fuction to use in transition:
                    'swing',
                    // Callback function. When the animation is finished, then remove the message box and run the callback:
                    function() { 
                        $(this).remove(); 
                        if (callback != null) callback();
                    }
                );
            }

        };
}])


/*
 JFB VALIDATE DIRECTIVE:

 This service provides a function that must be called in the link function of
 a directive, this provided function prepare the directive to evaluate the
 validate condition and show the results to the user. (Showing an animated
 alert box and/or changing the element's border color)

 Do not modify.
 */

.factory('jfbValidate', ['jfbValidateConfig', 'jfbValidateElement', 'jfbValidateMessageBoxAnimation',
    function(jfbValidateConfig, jfbValidateElement, jfbValidateMessageBoxAnimation) {

        return {

            configDirective: function(element, attrs, validate_condition, text_message_box) {

                $(document).ready(function() {
                    
                    setTimeout(function() {

                        if (attrs.jfbValidateIsAlert == null) {

                            attrs.jfbValidateIsAlert = false;

                            if (validate_condition(attrs.jfbValidateContent)) {

                                element.attr("jfb-validate-is-alert", "false");

                            } else {

                                element.attr("jfb-validate-is-alert", "true");
                            }

                        } else {

                            if (!validate_condition(attrs.jfbValidateContent)) {

                                element.attr("jfb-validate-is-alert", "true");
                            }
                        }
                    }, 200);


                    // Definition of the element's transition duration
                    jfbValidateElement.configElementTransitions(element);

                    // If the height of the showed message box is not defined in the directive parameters, use the default value defined in the config file
                    if (attrs.jfbValidateAlertHeight != null) var height_alert_box = attrs.jfbValidateAlertHeight;
                    else var height_alert_box = jfbValidateConfig.height_message_box;


                    //  ADD EVENT LISTENERS TO ELEMENT:


                    // When the element losts focus...
                    element.on('blur', function() {

                        // and the element is empty and it hasn't an alert message
                        if (!validate_condition(attrs.jfbValidateContent) && !attrs.jfbValidateIsAlert) {

                            // Put isAlert On true before the animation begins:
                            attrs.jfbValidateIsAlert = true;
                            element.attr("jfb-validate-is-alert", "true");

                            // Change the element's border color
                            jfbValidateElement.changeElementBorderColor(element, jfbValidateConfig.color_alert);

                            // Show the alert message box
                            if (attrs.jfbValidateShowAlert != 'FALSE' && attrs.jfbValidateShowAlert != 'False' && attrs.jfbValidateShowAlert != 'false')
                                jfbValidateMessageBoxAnimation.showAlertMessageBox(element, height_alert_box, text_message_box);

                            // and the element is not empty
                        } else if (validate_condition(attrs.jfbValidateContent) && !attrs.jfbValidateIsAlert) {

                            // Change the element's border color
                            jfbValidateElement.changeElementBorderColor(element, jfbValidateConfig.color_validated);
                        }
                    });

                    // When the element gains the focus...
                    element.on('focus', function() {

                        element.attr("jfb-validate-is-alert", "false");

                        // Change the element's border color
                        jfbValidateElement.changeElementBorderColor(element, jfbValidateConfig.color_focused);

                        // and it has an alert message
                        if (attrs.jfbValidateIsAlert) {

                            // Hide the alert message box
                            if (attrs.jfbValidateShowAlert != 'FALSE' && attrs.jfbValidateShowAlert != 'False' && attrs.jfbValidateShowAlert != 'false') {
                                jfbValidateMessageBoxAnimation.hideAlertMessageBox(element,

                                    // Callback: When the message box is removed, put isAlert on false
                                    function() {
                                        attrs.jfbValidateIsAlert = false;
                                    });

                            } else {

                                attrs.jfbValidateIsAlert = false;
                            }
                        }
                    });
                });
            }
        }
}]);
