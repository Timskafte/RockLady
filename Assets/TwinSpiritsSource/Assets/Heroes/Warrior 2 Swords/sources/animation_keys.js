




    var teclado: AnimationClip;
    
    function Update () {
    
    if (Input.GetKey(KeyCode.UpArrow))
    		{
    		GetComponent.<Animation>().Play ("run");}
    		
    else if(Input.GetKey(KeyCode.Space))
    		{
  			  GetComponent.<Animation>().Play ("attack");}
  			  
  	else 
   			 {
    		GetComponent.<Animation>().Play ("idle");}

   	 }
    



    
    
    
    
    
