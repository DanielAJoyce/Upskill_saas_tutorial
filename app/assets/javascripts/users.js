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
    
    submitBtn.val('Processing').prop('disabled', true);
    
        // collect credit card fields
    var ccNum = $('#card_number').val(),
        cvcNum = $('#card_code').val(),
        expMonth = $('#card_month').val(),
        expYear = $('#card_year').val();
    
    // Use Stripe JS library to check for card errors
    
    var error = false;
    
    //Validate Card Number
   if(!Stripe.card.validateCardNumber(ccNum))
   {
       
       error = true;
       alert('The credit card number is not valid');
   }
   
   //Validate CVC Number
   if(!Stripe.card.validateCVC(cvcNum))
   {
       error = true;
       alert('The CVC is not correct.');
   }
   // validate expiration date.
   if(!Stripe.card.validateExpiry(expMonth, expYear))
   {
       error = true;
       alert('The Expiration date is incorrect.');
   }
   
    
        // send card info to stripe
    if (error){
        submitBtn.val('Sign Up').prop('disabled', false);
    }
    else
    {
       Stripe.createToken({
        number: ccNum,
        cvc: cvcNum,
        exp_month: expMonth,
        exp_year: expYear
    }, stripeResponseHandler);
          
          return false;  
       
    }
    }); 
    // stripe returns card token
       function stripeResponseHandler(status, response)
       {
           var token = response.id; 
       //inject card token into hidden field.
       
            theForm.append($('<input type="hidden"name ="user[stripe_card_token]">').val(token));
               
           
// submit form to rails app
            theForm.get(0).submit();
       }
            

});
