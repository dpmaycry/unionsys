$(document).ready(function () {
             $.idcode.setCode();
			 $("form").submit(function(){
			var IsBy = $.idcode.validateCode();
			if(IsBy==false)
			{
				alert("Verification code is wrong!");
				return false;
			}
			});
        });