class Camera {
    constructor(x, y, z, ex, ey, ez) {
        this.x = x;
        this.y = y;
        this.z = z;
        this.ex = ex;
        this.ey = ey;
        this.ez = ez;
    }
}


const arr = [
              new Camera(-436.817, 531.013, -591.52448, -42.66959, -0.00064, -143.66461),
              new Camera(-738.163, -190.207, -16.98531, 22.49689, -0.00042, -91.66675),
              new Camera(-491.962, 454.262, 300.97076, -45.67209, -0.00058, -58.33403),
              new Camera(481.245, 3.26, 332.92917, -0.67329, -0.00054, 50.00017),
              new Camera(816.921, 153.945, -298.11179, -19.84025, -0.00092, 110.83527),
              new Camera(375.164, -107.182, -487.36505, 16.15976, -0.00094, 143.66801 ),
              new Camera(-36.991, 1000.279, 15.42855, -86.66962, 0, -1.16462), // <--
              new Camera(1888.71, -969.357, 1119.8103, 22.83041, 0, 58.83541),
              new Camera(-1765.58, 303.144, 1646.04834, -7.66959, 0, -45.66461),
              new Camera(-2055.99, 2010.586, -3870.01855, -25.16959, 0,  -152.16464 ),
              new Camera(-1859.188, -1557.189, 1768.87964, 30.83041, 0, -45.16463)

          ]


function selectCamera(camera, index) {
    camera.x = arr[index].x;
    camera.y = arr[index].y;
    camera.z = arr[index].z;
    camera.eulerRotation.x = arr[index].ex;
    camera.eulerRotation.z = arr[index].ey;
    camera.eulerRotation.y = arr[index].ez;
}
