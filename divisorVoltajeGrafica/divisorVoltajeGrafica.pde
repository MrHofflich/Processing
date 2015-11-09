/**
Divisor Voltaje  

Sketch diseñado para enseñar la teoría de un divisor de Voltaje
2 perillas controlan 2 resistencias, mientras que se mueve 1 la otra queda fija y se calcula el valor de Vout
Se puede observar tambien una barra que sube y baja dependiendo el valor de Vout
y se puede observar una gráfica del movimiento de corriente.
  Vout = Vi * (valorR1/ (valorR1+valorR2));

Alexander Höfflich
Hackerspace Mty
10/16/2015 San Carlos, Sonora
*/
// Importas la libreria para el control
import controlP5.*;

//Paleta de colores para no batallar
color[] minard = {#666666, #607F9C, #E9CCAE, #FFFFF3, #D01312};

//CReas el ojeto para el control
ControlP5 cp5;

//Defines el tipo de objeto y lo declaras
Knob R1;
Knob R2;


//Declaras una variable para guardar el valor e la formula que estas valuando
float Vout;

//Defines las variables a usar en la formula que estas evaluando   Vout = Vi * (valorR1/ (valorR1+valorR2));
float Vi=5;
float valorR1,valorR2,valorVoltaje;

//Etiquetas para texto
float etiqueta;

//Variables para grafica
int[] seg;
FloatList VoltajeOut;
float puntoVoltajeY;
FloatList VoltajeOutActual;     
FloatList VoltajeOutPasado;
int index;
int i ;
void setup() {
  
  size(1400,1000);
  smooth();
  noStroke();
  
  //Creas ek objeto de control
  cp5 = new ControlP5(this);

  VoltajeOut = new FloatList();
  VoltajeOutPasado = new FloatList();
  VoltajeOutActual = new FloatList();
  VoltajeOutPasado.append(index);

  //Agregas dos perillas que representaran nuestras 2 resistencias variables           
  R1 = cp5.addKnob("R1")
               .setRange(0,1000000)
               .setValue(1)
               .setPosition(width/3+40,80)
               .setRadius(80)
               .setNumberOfTickMarks(20)
               .setTickMarkLength(4)
               .snapToTickMarks(false)
               .setColorForeground(color(255))
               .setColorBackground(color(0, 160, 100))
               .setColorActive(color(255,255,0))
               .setDragDirection(Knob.HORIZONTAL)
               ;
               
  R2 = cp5.addKnob("R2")
             .setRange(0,1000000)
             .setValue(0)
             .setPosition(width/3+40,350)
             .setRadius(80)
             .setNumberOfTickMarks(20)
             .setTickMarkLength(4)
             .snapToTickMarks(false)
             .setColorForeground(color(255))
             .setColorBackground(color(0, 160, 100))
             .setColorActive(color(255,255,0))
             .setDragDirection(Knob.HORIZONTAL)
             ;  
                
  
}

void draw() {
  //Separas el fondo en 3 partes
  noStroke();
  fill(minard[0]);
  rect(0,0,width/3,height);
  fill(minard[1]);
  rect(width/3,0,width/3,height);
  fill(minard[3]);
  rect(width/3*2,0,width/3,height);
  
  //Agregas los textos necesarios
  textAlign(CENTER);
  textSize(20);
  text("Valor de Vout",0,20,width/3,40);
  text("Valor de Resistencias", width/3, 20, width/3,40);
  fill(0);
  text("Gráfica de Voltaje", width/3*2, 20, width/3, 40);
  textAlign(CENTER);
  textSize(15);
  fill(255);
  text(Vout, 120,etiqueta);

  etiqueta = map(Vout,0,5,400,100);
  
  textAlign(LEFT);
  text("Vout = Vi * (valorR1/ (valorR1+valorR2)", 50,450);
  text("Vout = " + Vi + " * ( " + valorR1 + " / " + valorR2 + ")", 50, 480);
  text("Vout = " + Vout + " V", 50, 510);
  text("Hecho por @MrHofflich", 50, 990);
  
  //Aqui es donde se ve la cantidad de voltaje de Vout
  fill(150,100);
  rect(50,100,30,300);
  fill(255,0,0);
  rect(50,400,30,valorVoltaje);
  
  //Aqui empiezas con los calculos
  valorR1 = int((R1.getValue()));
  valorR2 = int(R2.getValue());
  Vout = Vi * (valorR1/ (valorR1+valorR2));
  valorVoltaje= map(Vout,0,5,0,-300);
  // Aqui empieza la grafica+80
  stroke(0);
  line((width/3*2)+30, 200,(width/3*2)+30, 400);
  line((width/3*2)+30, 400,(width/3*2)+430,400);
  
  puntoVoltajeY = map(Vout, 0, 5, 400,200);
  VoltajeOut.append(puntoVoltajeY);

    if(VoltajeOut.size() >=20) {
      VoltajeOut.remove(0);
      
    }
    


  strokeWeight(4);
  stroke(255,0,0);

  for(int i =0; i < VoltajeOutPasado.size(); i++) {
      point(width/3*2+30+(i*20),VoltajeOutPasado.get(i));
  }

  
  println("VoltajeActual" + VoltajeOutPasado.get(index));
  
  if(VoltajeOut.get(index) != VoltajeOutPasado.get(index)){
      VoltajeOutPasado.append(VoltajeOut.get(index));
      println(index);
      index++;
      if(index>=18) {
        index=18;
      }
  }




}