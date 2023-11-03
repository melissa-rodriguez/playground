/**
 * <p>This example uses the attraction behavior to inflate a 3D mesh.
 * The mesh vertices are re-created as physics particles and connected
 * using springs. Upon mouse press the inflation force is applied,
 * counteracting the forces created by the springs, causing the mesh to
 * expand and deform.</p>
 * 
 * <p>Usage: Click and hold mouse button to inflate mesh</p>
 */

/* 
 * Copyright (c) 2010 Karsten Schmidt
 * 
 * This demo & library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * http://creativecommons.org/licenses/LGPL/2.1/
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */

import toxi.geom.*;
import toxi.geom.mesh.subdiv.*;
import toxi.geom.mesh.*;
import toxi.physics3d.*;
import toxi.physics3d.behaviors.*;
import toxi.physics3d.constraints.*;
import toxi.processing.*;

VerletPhysics3D physics;
AttractionBehavior3D inflate;
WETriangleMesh box;

ToxiclibsSupport gfx;

float dist;
ArrayList<Spring> springs;

void setup() {
  size(1080, 1080, P3D);
  gfx = new ToxiclibsSupport(this);
  initPhysics();
}

void draw() {
  physics.update();
  for (Vertex v : box.vertices.values()) {
    v.set(physics.particles.get(v.id));
  }
  box.center(null);
  for (Vertex v : box.vertices.values()) {
    physics.particles.get(v.id).set(v);
  }

  box.computeFaceNormals();
  box.faceOutwards();
  box.computeVertexNormals();
  background(0);
  translate(width / 2, height / 2, 500);
  rotateX((height / 2 - mouseY) * 0.01f);
  rotateY((width / 2 - mouseX) * 0.01f);
  noFill();
  lights();
  directionalLight(255, 255, 255, -200, 1000, 500);
  specular(255);
  shininess(16);
  gfx.origin(new Vec3D(), 50);
  //fill(192);
  //noStroke();
  stroke(#467302);
  gfx.mesh(box, true, 5);
  

  for (Spring s : springs) {
    s.display();
  }
  //saveFrame("gif/img####.png");
  //rec();
}

void initPhysics() {
  //background(0);
  box = new WETriangleMesh();
  // create a simple start mesh
  //box.addMesh(new Cone(new Vec3D(0, 0, 0), new Vec3D(0, 1, 0), 10, 50, 100).toMesh(4));
  box.addMesh(new AABB(new Vec3D(), 50).toMesh());
  // then subdivide a few times...this increases mesh resolution
  box.subdivide();
  box.subdivide();
  box.subdivide();
  box.subdivide();
  physics = new VerletPhysics3D();
  physics.setWorldBounds(new AABB(new Vec3D(), 180));

  //physics = new VerletPhysics3D();
  Vec3D gravity = new Vec3D(0, 1, 0);
  GravityBehavior3D gb = new GravityBehavior3D(gravity);
  physics.addBehavior(gb);

  springs = new ArrayList<Spring>();

  // turn mesh vertices into physics particles
  for (Vertex v : box.vertices.values()) {
    VerletParticle3D p = new VerletParticle3D(v);
    physics.addParticle(p);    

    VerletParticle3D p2 = new VerletParticle3D(p.scale(1.2));
    physics.addParticle(p2);
    dist = p.distanceTo(p2);

    //a.lock();
    //println(a2);
    //physics.addSpring(new VerletSpring3D(a, a2, a.distanceTo(a2), 0.005f));
    Spring s = new Spring(p, p2, p.distanceTo(p2), 0.005f);
    springs.add(s); //add to the arraylist
    physics.addSpring(s);
    p.lock();
  }




  // turn mesh edges into springs
  //for (WingedEdge e : box.edges.values()) {
  //  VerletParticle3D a = physics.particles.get(((WEVertex) e.a).id);
  //  VerletParticle3D b = physics.particles.get(((WEVertex) e.b).id);
  //  physics.addSpring(new VerletSpring3D(a, b, a.distanceTo(b), 0.005f));

  //  VerletParticle3D a2 = new VerletParticle3D(a.scale(2));
  //  physics.addParticle(a2);
  //  dist = a.distanceTo(a2);

  //  //a.lock();
  //  //println(a2);
  //  //physics.addSpring(new VerletSpring3D(a, a2, a.distanceTo(a2), 0.005f));
  //  Spring s = new Spring(a, a2, a.distanceTo(a2),0.005f);
  //  springs.add(s); //add to the arraylist
  //  physics.addSpring(s);
  //}
}

void keyPressed() {
  if (key == 'r') {
    initPhysics();
  }
}

GravityBehavior3D wb;
void mousePressed() {
  inflate=new AttractionBehavior3D(new Vec3D(), 400, -0.3f, 0.001f);
  Vec3D wind = new Vec3D(0, -2, 0);
  wb = new GravityBehavior3D(wind);
  physics.addBehavior(wb);
  //physics.addBehavior(inflate);
}

void mouseReleased() {
  physics.removeBehavior(wb);
}
