module ellipseCylinder(h,a,b,res=100,center=false){
  resize([0,2*b,0])
  cylinder(h = h, r = a,$fn=res,center=center);
}

unitcell = 10;
height = 20;
line = 6;
row = 6;
axis_long = 6;
axis_short = 3;

bridge_length = 3;
support = 1;

a = axis_long;
b = axis_short;

difference(){
    cube([unitcell*line,unitcell*row,height]);
for (i=[0:line]){
    for (j=[0:row]){
        
        translate([unitcell*i,unitcell*j,height/2])
        //translate([unitcell/2,unitcell/2,height/2])
        if((i+j)%2==0){
            ellipseCylinder(height+4,a,b,res=200,center=true);
        }else{
            ellipseCylinder(height+4,b,a,res=200,center=true);
        }
    }
}
};


for (i=[0:line-1]) {
    
    if (i%2 == 0){
        translate([unitcell*i+axis_long, unitcell*row, 0])
        cube([unitcell-(axis_long+axis_short), support, height]);
    } else {
        translate([unitcell*i+axis_short, unitcell*row, 0])
        cube([unitcell-(axis_long+axis_short), support, height]);
    }
    
    translate([i*unitcell + bridge_length/2, unitcell*row+support, 0])
    cube([unitcell-bridge_length/2, 2, height]);
    
    if (i != line-1) {
        translate([(i+1)*unitcell - bridge_length/2, unitcell*row+support, 5])
        cube([bridge_length, 2, 1]);
        translate([(i+1)*unitcell - bridge_length/2, unitcell*row+support, 13])
        cube([bridge_length, 2, 1]);
    }
}