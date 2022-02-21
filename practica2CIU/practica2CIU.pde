ArrayList<Coordenadas> coordenadas;
boolean get3D = false;
PShape obj;
PShape surface;
boolean inicio = true;
PFont textStyle;

void setup() {
  size(500,500,P3D);
  background(255);
  coordenadas = new ArrayList<Coordenadas>();
}


void draw() {
  fill(0);
  
  if(inicio == true){
      textSize(14);
      fill(174, 214, 241);
      line (height/2,0,height/2,150);
      line (height/2,350,height/2,height);
      rect(100,150,300,200);
      fill(0);
      
      textSize(14);
      println(get3D);
      rect(20,10,75,25);
      fill(255);
      text("Get 3D", 35,26);
      
      fill(0);
      text("Para convertir el perfil de una figura", 120,180);
      text("en un objeto tridimensional, dibujalo ", 120,200);
      text("en el lado izquierdo de la pantalla ", 120,220);
      text("haciendo click con el ratón", 120,240);
      
      text("Para mostrar el resultado, pulsa en el", 120,270);
      text("boton 'Get 3D'", 120,290);
      
      fill(255);
      rect(210,310,75,25);
      
      fill(0);
      text("Aceptar", 220,327);
      
      
      
      if(mousePressed && mouseX>210 && mouseX<285 && mouseY>310 && mouseY<335 && inicio == true){
        inicio = false;
      } 
      
    
    
    
  }else{
    background(255);
    if(get3D == false){
      textSize(14);
      rect(20,10,75,25);
      fill(255);
      text("Get 3D", 35,26);  
      
    }else{
      rect(20,450,75,25);
      fill(255);
      text("Reset", 40,466);  
    }
    
    if(get3D == false && inicio == false){
      if (mouseX > 250) {
        cursor(CROSS);
      } else {
        cursor(ARROW);
      }  
    }
    
    
    if(inicio == false)line (height/2,0,height/2,height);
    fill(0);
    
    if(mousePressed && mouseX>(height/2) && get3D == false && inicio == false){
      coordenadas.add(new Coordenadas(mouseX, mouseY));
    } 
    
    
    
     obj=createShape();
     obj.beginShape();
     obj.noFill();
     obj.stroke(0);
     obj.strokeWeight(3);
     for(Coordenadas c : coordenadas){
        obj.vertex(c.getX(), c.getY());
     }    
     obj.endShape();
     
     if(get3D == false) shape(obj);     
    
      
    if(mousePressed && mouseX>20 && mouseX<95 && mouseY>10 && mouseY<45 && get3D == false && inicio == false){
        get3D = true;
    } 
    
    if(mousePressed && mouseX>20 && mouseX<95 && mouseY>450 && mouseY<485 && get3D == true && inicio == false){
        get3D = false;
        coordenadas.clear();
        background(255);
    } 
   
     
    if(get3D == true){  
      
      for(int i=0;i<obj.getVertexCount();i++){
        PVector vect=obj.getVertex(i);
        vect.x -= width/2;
        vect.y -= height/2;  
        obj.setVertex(i,vect.x,vect.y,vect.z);
      }
      
      surface=createShape();
      surface.beginShape(TRIANGLES);
      surface.fill(174, 214, 241);
      surface.stroke(46, 134, 193);      
      surface.strokeWeight(2);
      
      for (int i=0; i<obj.getVertexCount()-1;i++){
        PVector v = obj.getVertex(i);
        PVector vNext = obj.getVertex(i+1);  
        
        for (int theta=0;theta<180;theta++){   
          float x1=v.x;
          float z1=v.z;           
          v.x=x1*cos(theta)-z1*sin(theta);
          v.z=x1*sin(theta)+z1*cos(theta);
          surface.vertex(v.x,v.y,v.z);           
          
          float x2=vNext.x;
          float z2=vNext.z;
          vNext.x=x2*cos(theta)-z2*sin(theta);
          vNext.z=x2*sin(theta)+z2*cos(theta);
          surface.vertex(vNext.x,vNext.y,vNext.z);        
        }
      }
      
      surface.endShape();
      translate(width/2, height/2);
      if(get3D)shape(surface);    
    } 
    
    text("Help(h)", 100,490);
  
    if (keyPressed == true) {
      if(key == 'h'){
        inicio = true;
      }
    }
  
  
  }
  
  
  
 
}



