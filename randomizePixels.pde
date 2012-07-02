PImage src;
PImage dstn;
HashMap library;
float probability;
float divisor;
color d = (0);
ArrayList<Integer> colors = new ArrayList<Integer>();
ArrayList<Float> probs = new ArrayList<Float>();



void setup() {
  library = new HashMap<Integer, Object>();
  size(3504,2238 );
  String srcfile = ("bath128.png");
  src = loadImage(srcfile);
  int totalPixels = (width*height);
  dstn = createImage(src.width, src.height, RGB);
  src.loadPixels();
  

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int loc = x + y*width;
      color d = src.get(x,y); // get pixel color at desired location
      dstn.pixels[loc] = color(d); 
      if (library.containsKey(d)) {
        int val = ((Integer) library.get(d)).intValue(); //accumulator 
         library.put(d, new Integer(val + 1));  // add 1 to
      } else {
         library.put(d,1); //adds entry & a value of 1 if entry does not exist
         colors.add(d);
        println(x + "," + y); 
      }      
    }
   } 
   
   
   for (int i = 0; i < colors.size();i++) { // Here we make a table or probabiities.
    divisor = ((Integer) library.get(colors.get(i))).intValue();
    float probability = (divisor / colors.size());
    probs.add(probability); // add element in array probs (number of occurrances of a color on the right/ total pixels on right )
    }
       float pa = 0;
 for (int z = 0;z < probs.size();z++) {
   pa = pa + (probs.get(z));
 }
   for (int y = 0; y < height; y++) {
     for (int x = 0; x < width; x++) {
       int loc = x + y*width;
       //color d = src.get(x,y); // get pixel color at desired location
       float chance = random(pa);
       int acc = 0;
       float probAccum = (probs.get(acc));
       while (chance > probAccum) {
        acc++;
        probAccum = probAccum + (probs.get(acc));
      }
       dstn.pixels[loc] = (colors.get(acc)); 
     }
   }

 println(pa);
 //println(totalPixels);
 //println(library);
 //println(probs); 
 //println(colors); 
 dstn.updatePixels();
 image(dstn,0,0); 
 saveFrame(srcfile + ".output-###2.png"); 
 noLoop();
}
