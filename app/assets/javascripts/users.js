//Document Ready





/* global $ */ // this tells it that jquery is already imported elsewhere.
/* global Stripe */ 

$(document).on('turbolinks:load', function() {
    
    var theForm = $('#pro_form');
    var submitBtn = $('#form-submit-btn');
    
    //Set Stripe Public Key
    Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content'));
    
    
    // When user clicks form submit button
    submitBtn.click(function(event){
        //prevent default submission behavior.
        event.preventDefault();
        
        // collect credit card fields
        var ccNum = $('#card_number').val(),
            cvcNum = $('#card_code').val(),
            expMonth = $('#card_month').val(),
            expYear = $('#card_year').val();
            
        // send card info to stripe
        
        Stripe.createToken({
            number: ccNum,
            cvc: cvcNum,
            exp_month: expMonth,
            exp_year: expYear
        }, stripeResponseHandler);
            
            
            // stripe returns card token
// Inject card token as hidden field into form
// submit form to rails app
    })
    
})