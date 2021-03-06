/*
 *  FxDraw.m
 *  Fx
 *
 *  Created by tehis on 17/01/2009.
 *  
 *	This file is part of Fx.
 *
 *	Fx is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *	(at your option) any later version.
 
 *	Fx is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 
 *	You should have received a copy of the GNU General Public License
 *	along with Fx.  If not, see <http://www.gnu.org/licenses/>. 
 *
 */

#import "FxDraw.h"

@implementation FxDraw

-(float) state { return state; }
-(void) setState: (float) value { state = value; }

-(int) indexi { return indexi; }
-(void) setIndexi: (int) value { indexi = value; }

-(int) indexj { return indexj; }
-(void) setIndexj: (int) value { indexj = value; }

-(NSMutableDictionary*) patches { return patches; }

-(void) setGlobalAlpha: (float) value { gAlpha = value; }

-(void) setPatch: (NSString*) key: (int) on 
{
	[[patches objectForKey: key] setActive: on];
}

-(void) setParam: (NSString*) key: (char*) param: (float) value
{

}

-(FxDraw*) init {
	NSArray* names;
	NSString* name;
	int i;
	self = [super init];
	names = [NSArray arrayWithObjects: @"horizons", @"axial", @"grid", @"mesh", nil ];
	patches = [NSMutableDictionary new];
		
	for (i = 0; i < [names count]; i++)
	{
		name = [names objectAtIndex:i];
		[patches setObject: [[Patch new] init] forKey: name];
	}
										
	return self;
}

- (void) drawCell: (Cell *) cell: (int) i: (int) j: (int) k: (int) ws: (int) fr {
	
	currentCell = cell;
	state = [cell phase];
	indexi = i;
	indexj = j;
	indexk = k;
	worldSize = ws;
	frameRateRatio = fr;
		
	if ([[patches objectForKey: @"horizons"] active ]) {
		cp = [patches objectForKey: @"horizons"];
		[self horizons];
	}
	if ([[patches objectForKey: @"axial"] active ]) {
		cp = [patches objectForKey: @"axial"];
		[self axial];
	}
	if ([[patches objectForKey: @"grid"] active ]) {
		cp = [patches objectForKey: @"grid"];
		[self grid];
	}
	if ([[patches objectForKey: @"mesh"] active ]) {
		cp = [patches objectForKey: @"mesh"];
		[self mesh];
	}	
}

- (void) setCommon
{
	size = 0.6f;
	size *= 2.0f;
	halfscreen = 5.2f;
	halfscreen *= 2.0f;
	[cp mapValues: indexi: indexj: state];
	alpha = [cp alpha] * gAlpha;
	red = [cp red]; 
	green = [cp green];
	blue = [cp blue];
}

- (void) horizons {
	
	[self setCommon];
	left = (float)indexi * size - halfscreen;
	bottom = (float)indexj * size - halfscreen + (size / 2.0f);
	front = (float)indexk * size - halfscreen + (size / 2.0f);
	width = size;

	if (!isEven(indexk))
	{
		[self drawLine: left: bottom: front: left + width: bottom: front: map(1.0f - state, 1.0f, 2.0f)];
	}
	
}

- (void) axial {
	[self setCommon];
	left = (float)indexi * size - halfscreen + size - (size * 2.0f * state);
	bottom = (float)indexj * size - halfscreen + size - (size * 2.0f * state);
	front = (float)indexk * size - halfscreen + size - (size * 2.0f * state);
	width = height = depth = size * 4.0f * state;
	alpha = alpha * 0.1f;
	if (indexk == 0) {
		[self fillRect: 0];
	}
	if (indexi == 0) { 
		[self fillRect: 1];
	}
	if (indexi == worldSize - 2) { 
		left = left + (width * 2.0f);
		[self fillRect: 1];
	}
	if (indexj == 0) {
		[self fillRect: 2];
	}
	if (indexj == worldSize - 1) { 
		bottom = bottom + height;
		[self fillRect: 2];
	}
	
}



- (void) grid {
	
	float w, n, lineWidth, scale;
	
	[self setCommon];
	
	if (indexk == 0 || indexk == worldSize - 1) // indexk == worldSize / 2
	{
		
		left = (float)indexi * size - halfscreen + size;
		bottom = (float)indexj * size - halfscreen + size;
		front = (float)indexk * size - halfscreen + (size / 2.0f);
		
		lineWidth = 1.0f;
		
		scale = 1.0f;
		
		if (indexi > 0)
		{
			// 4, 10, 12, 13, 15, 21
			w = [[[currentCell habitat] objectAtIndex:10] phase]; // 0 - neumann
			
			[self drawLine: left : bottom : front + map(state, scale * -1.0f, scale) : left - size : bottom : front + map(w, scale * -1.0f, scale): lineWidth ];
			
		}
		
		if (indexj > 0)
		{
			
			n = [[[currentCell habitat] objectAtIndex:4] phase]; // 1 - neumann
			
			[self drawLine: left : bottom : front + map(state, scale * -1.0f, scale) : left : bottom - size : front + map(n, scale * -1.0f, scale) : lineWidth ];
			
		}
	}
	
	if (indexj == 0 || indexj == worldSize - 1) // indexj == worldSize / 2
	{
		
		left = (float)indexi * size - halfscreen + size;
		bottom = (float)indexj * size - halfscreen + (size / 2.0f);
		front = (float)indexk * size - halfscreen + size;
		
		lineWidth = 1.0f;
		
		scale = 1.0f;
		
		if (indexi > 0)
		{
			
			n = [[[currentCell habitat] objectAtIndex:10] phase]; // 1 - neumann
			
			[self drawLine: left : bottom + map(state, scale * -1.0f, scale) : front : left - size : bottom + map(n, scale * -1.0f, scale) : front : lineWidth ];
			
		}
		
		if (indexk > 0)
		{
			// 4, 10, 12, 13, 15, 21
			w = [[[currentCell habitat] objectAtIndex:12] phase]; // 0 - neumann
			
			[self drawLine: left : bottom + map(state, scale * -1.0f, scale) : front : left : bottom + map(w, scale * -1.0f, scale): front - size : lineWidth ];
			
		}
		
	}
	
	
	if (indexi == 0 || indexi == worldSize - 1)  // indexj == worldSize / 2
	{
		
		left = (float)indexi * size - halfscreen + (size / 2.0f);
		bottom = (float)indexj * size - halfscreen + size;
		front = (float)indexk * size - halfscreen + size;
		
		lineWidth = 1.0f;
		
		scale = 1.0f;
		
		if (indexj > 0)
		{
			
			n = [[[currentCell habitat] objectAtIndex:4] phase]; // 1 - neumann
			
			[self drawLine: left + map(state, scale * -1.0f, scale) : bottom : front : left + map(n, scale * -1.0f, scale) : bottom - size : front : lineWidth ];
			
		}
		
		if (indexk > 0)
		{
			// 4, 10, 12, 13, 15, 21
			w = [[[currentCell habitat] objectAtIndex:12] phase]; // 0 - neumann
			
			[self drawLine: left + map(state, scale * -1.0f, scale) : bottom : front : left + map(w, scale * -1.0f, scale) : bottom : front - size : lineWidth ];
			
		}
		
	}
	
}

- (void) mesh {
	
	
	[self setCommon];
	left = (float)indexi * size - halfscreen + size - (size * state);
	bottom = (float)indexj * size - halfscreen + size - (size * state);
	front = (float)indexk * size - halfscreen + size - (size * state);
	width = height = depth = size * 2.0f * state;
	
	if (
		(indexi == 3 && indexj == 3) || 
		(indexi == 3 && indexk == 3) ||
		(indexj == 3 && indexk == 3) ||
		
		(indexi == 3 && indexj == 12) || 
		(indexi == 3 && indexk == 12) ||
		(indexj == 3 && indexk == 12) ||
		
		(indexj == 3 && indexi == 12) ||
		(indexk == 3 && indexi == 12) ||
		(indexk == 3 && indexj == 12) ||
		
		(indexi == 12 && indexk == 12) ||
		(indexi == 12 && indexj == 12) ||
		(indexk == 12 && indexj == 12)
		)
	{
		[self strokeCube];
	}
	
	left = (float)indexi * size - halfscreen + size - (size * 0.5f * state);
	bottom = (float)indexj * size - halfscreen + size - (size * 0.5f * state);
	front = (float)indexk * size - halfscreen + size - (size * 0.5f * state);
	width = height = depth = size * state;
	
	if (
		(indexi == 7 && indexj == 7) || 
		(indexi == 7 && indexk == 7) ||
		(indexj == 7 && indexk == 7) ||
		
		(indexi == 7 && indexj == 8) || 
		(indexi == 7 && indexk == 8) ||
		(indexj == 7 && indexk == 8) ||
		
		(indexj == 7 && indexi == 8) ||
		(indexk == 7 && indexi == 8) ||
		(indexk == 7 && indexj == 8) ||
		
		(indexi == 8 && indexk == 8) ||
		(indexi == 8 && indexj == 8) ||
		(indexk == 8 && indexj == 8)
		)
	{
		[self strokeCube];
	}
	
}

// basic drawing functions

- (void) drawRect {
	glColor4f(red, green, blue, alpha);
	glBegin(GL_POLYGON);

	glVertex3f (left, bottom, 0.0f);
	glVertex3f (left + width, bottom, 0.0f);
	glVertex3f (left + width, bottom + height, 0.0f);
	glVertex3f (left, bottom + height, 0.0f);

	glEnd();

}

- (void) drawAxialRect: (float) colN: (float) colE: (float) colS: (float) colW {
	glBegin(GL_POLYGON);

	glColor4f(colS, colS, colS, alpha);
	glVertex3f (left, bottom, front);
	glColor4f(colE, colE, colE, alpha);
	glVertex3f (left + width, bottom, front);
	glColor4f(colN, colN, colN, alpha);
	glVertex3f (left + width, bottom + height, front);
	glColor4f(colW, colW, colW, alpha);
	glVertex3f (left, bottom + height, front);

	glEnd();

}

- (void) fillRect {
	glColor4f(red, green, blue, alpha);
	glEnable(GL_POLYGON_SMOOTH);
	glBegin(GL_POLYGON);

	glVertex2f (left, bottom);
	glVertex2f (left + width, bottom);

	glVertex2f (left + width, bottom);
	glVertex2f (left + width, bottom + height);
	
	glVertex2f (left + width, bottom + height);
	glVertex2f (left, bottom + height);
	
	glVertex2f (left, bottom + height);
	glVertex2f (left, bottom);	

	glEnd();
	glDisable(GL_POLYGON_SMOOTH);
	
}

- (void) strokeRect {
	glColor4f(red, green, blue, alpha);
	glEnable(GL_LINE_SMOOTH);
	glLineWidth(1.2f);
	glBegin(GL_LINES);

	glVertex2f (left, bottom);
	glVertex2f (left + width, bottom);

	glVertex2f (left + width, bottom);
	glVertex2f (left + width, bottom + height);
	
	glVertex2f (left + width, bottom + height);
	glVertex2f (left, bottom + height);
	
	glVertex2f (left, bottom + height);
	glVertex2f (left, bottom);	

	glEnd();
	glDisable(GL_LINE_SMOOTH);
}

- (void) fillRect: (int) plane {
	glColor4f(red, green, blue, alpha);
	glEnable(GL_POLYGON_SMOOTH);
	glBegin(GL_POLYGON);

	switch (plane)
	{
		case 0:
			glVertex3f (left, bottom, front);
			glVertex3f (left + width, bottom, front);

			glVertex3f (left + width, bottom, front);
			glVertex3f (left + width, bottom + height, front);
			
			glVertex3f (left + width, bottom + height, front);
			glVertex3f (left, bottom + height, front);
			
			glVertex3f (left, bottom + height, front);
			glVertex3f (left, bottom, front);
			
			break;
			
		case 1:
			glVertex3f (left, bottom, front);
			glVertex3f (left, bottom, front + depth);

			glVertex3f (left, bottom, front + depth);
			glVertex3f (left, bottom + height, front + depth);
			
			glVertex3f (left, bottom + height, front + depth);
			glVertex3f (left, bottom + height, front);
			
			glVertex3f (left, bottom + height, front);
			glVertex3f (left, bottom, front);
			
			break;

		case 2:
			glVertex3f (left, bottom, front);
			glVertex3f (left + width, bottom, front);

			glVertex3f (left + width, bottom, front);
			glVertex3f (left + width, bottom, front + depth);
			
			glVertex3f (left + width, bottom, front + depth);
			glVertex3f (left, bottom, front + depth);
			
			glVertex3f (left, bottom, front + depth);
			glVertex3f (left, bottom, front);
			
			break;
			
	}

	glEnd();
	glDisable(GL_POLYGON_SMOOTH);
	
}

- (void) strokeRect: (int) plane: (float) lineWidth {
	glColor4f(red, green, blue, alpha);
	glEnable(GL_LINE_SMOOTH);
	glLineWidth(lineWidth);
	glBegin(GL_LINES);
	
	switch (plane)
	{
		case 0:
			glVertex3f (left, bottom, front);
			glVertex3f (left + width, bottom, front);

			glVertex3f (left + width, bottom, front);
			glVertex3f (left + width, bottom + height, front);
			
			glVertex3f (left + width, bottom + height, front);
			glVertex3f (left, bottom + height, front);
			
			glVertex3f (left, bottom + height, front);
			glVertex3f (left, bottom, front);
			
			break;
			
		case 1:
			glVertex3f (left, bottom, front);
			glVertex3f (left, bottom, front + depth);

			glVertex3f (left, bottom, front + depth);
			glVertex3f (left, bottom + height, front + depth);
			
			glVertex3f (left, bottom + height, front + depth);
			glVertex3f (left, bottom + height, front);
			
			glVertex3f (left, bottom + height, front);
			glVertex3f (left, bottom, front);
			
			break;

		case 2:
			glVertex3f (left, bottom, front);
			glVertex3f (left + width, bottom, front);

			glVertex3f (left + width, bottom, front);
			glVertex3f (left + width, bottom, front + depth);
			
			glVertex3f (left + width, bottom, front + depth);
			glVertex3f (left, bottom, front + depth);
			
			glVertex3f (left, bottom, front + depth);
			glVertex3f (left, bottom, front);
			
			break;
			
	}


	glEnd();
	glDisable(GL_LINE_SMOOTH);
}

- (void) strokeCube {
	glColor4f(red, green, blue, alpha);
	glEnable(GL_LINE_SMOOTH);
	glLineWidth((1.0f - state) * 2.0f);
	glBegin(GL_LINES);
	
	
	glVertex3f (left, bottom, front);
	glVertex3f (left + width, bottom, front);

	glVertex3f (left + width, bottom, front);
	glVertex3f (left + width, bottom + height, front);
	
	glVertex3f (left + width, bottom + height, front);
	glVertex3f (left, bottom + height, front);
	
	glVertex3f (left, bottom + height, front);
	glVertex3f (left, bottom, front);	
	
	glVertex3f (left, bottom, front);
	glVertex3f (left, bottom, front + depth);
	
	glVertex3f (left, bottom, front + depth);
	glVertex3f (left + width, bottom, front + depth);
	
	glVertex3f (left + width, bottom, front + depth);
	glVertex3f (left + width, bottom, front);

	glVertex3f (left, bottom + height, front);
	glVertex3f (left, bottom + height, front + depth);
	
	glVertex3f (left, bottom + height, front + depth);
	glVertex3f (left + width, bottom + height, front + depth);
	
	glVertex3f (left + width, bottom + height, front + depth);
	glVertex3f (left + width, bottom + height, front);
	
	glVertex3f (left, bottom, front + depth);
	glVertex3f (left, bottom + height, front + depth);

	glVertex3f (left + width, bottom, front + depth);
	glVertex3f (left + width, bottom + height, front + depth);
	
	glEnd();
	glDisable(GL_LINE_SMOOTH);

}

- (void) drawVertex3f: (float) startx: (float) starty: (float) startz: (float) endx: (float) endy: (float) endz: (float) lineWidth {
	glColor4f(red, green, blue, alpha);
	glEnable(GL_LINE_SMOOTH);
	glLineWidth(lineWidth);
	glBegin(GL_LINES);
	
	glVertex3f(startx, starty, startz);
	glVertex3f(endx, endy, endz);
	
	glEnd();
	glDisable(GL_LINE_SMOOTH);
		
}

- (void) stroke3Dvertex {
	glColor4f(red, green, blue, alpha);
	glEnable(GL_LINE_SMOOTH);
	glLineWidth(state * 4.0f);
	glBegin(GL_LINES);
	
	if (state <= 0.05)
	{
		glVertex3f (left, bottom, front);
		glVertex3f (left + width, bottom, front);
	}
	
	if (state > 0.05 && state <= 0.1)
	{
		glVertex3f (left + width, bottom, front);
		glVertex3f (left + width, bottom + height, front);
	}
	
	if (state > 0.1 && state <= 0.2)
	{	
		glVertex3f (left + width, bottom + height, front);
		glVertex3f (left, bottom + height, front);
	}
	
	if (state > 0.2 && state <= 0.3)
	{	
		glVertex3f (left, bottom + height, front);
		glVertex3f (left, bottom, front);	
	}	
	
	if (state > 0.3 && state <= 0.4)
	{	
		glVertex3f (left, bottom, front);
		glVertex3f (left, bottom, front + depth);
	}
	
	if (state > 0.4 && state <= 0.5)
	{	
		glVertex3f (left, bottom, front + depth);
		glVertex3f (left + width, bottom, front + depth);
	}
	
	if (state > 0.5 && state <= 0.6)
	{				
		glVertex3f (left + width, bottom, front + depth);
		glVertex3f (left + width, bottom, front);
	}
	
	if (state > 0.6 && state <= 0.7)
	{	
		glVertex3f (left, bottom + height, front);
		glVertex3f (left, bottom + height, front + depth);
	}
	
	if (state > 0.7 && state <= 0.8)
	{		
		glVertex3f (left, bottom + height, front + depth);
		glVertex3f (left + width, bottom + height, front + depth);
	}
	
	if (state > 0.8 && state <= 0.9)
	{		
		glVertex3f (left + width, bottom + height, front + depth);
		glVertex3f (left + width, bottom + height, front);
	}
	
	if (state > 0.9 && state <= 0.95)
	{		
		glVertex3f (left, bottom, front + depth);
		glVertex3f (left, bottom + height, front + depth);
	}
	
	if (state > 0.95)
	{		
		glVertex3f (left + width, bottom, front + depth);
		glVertex3f (left + width, bottom + height, front + depth);
	}
	
	glEnd();
	glDisable(GL_LINE_SMOOTH);

}


- (void) drawPoint: (float) x: (float) y: (float) z: (float) sz {
	glColor4f(red, green, blue, alpha);
	glEnable(GL_POINT_SMOOTH);
	glPointSize(sz);
	glBegin(GL_POINTS);
	glVertex3f(x, y, z);
	glEnd();
	glDisable(GL_POINT_SMOOTH);
}


- (void) drawLine: (float) startx: (float) starty: (float) startz: 
		(float) endx: (float) endy: (float) endz: (float) lineWidth {
	glColor4f(red, green, blue, alpha);
	glEnable(GL_LINE_SMOOTH);
	glLineWidth(lineWidth);
	glBegin(GL_LINES);
	
	glVertex3f(startx, starty, startz);
	glVertex3f(endx, endy, endz);
	
	glEnd();
	glDisable(GL_LINE_SMOOTH);
}


- (void) drawCircle: (float) cx: (float) cy: (float) r: (int) num_segments: (bool) fill { 
	int i;
	float theta, tangetial_factor, radial_factor, x, y;
	theta = 2 * pi / num_segments;
	tangetial_factor = tanf(theta);
	radial_factor = cosf(theta);
	x = r;
	y = 0;
	
	if (fill) {
		glBegin(GL_POLYGON);	
	}
	{
		glBegin(GL_LINE_LOOP);
	}
	glColor4f(red, green, blue, alpha);
	for(i = 0; i < num_segments; i++) 
	{ 
		glVertex3f(x + cx, y + cy, front);
        
		float tx = -y; 
		float ty = x; 
		x += tx * tangetial_factor; 
		y += ty * tangetial_factor; 
		x *= radial_factor; 
		y *= radial_factor; 
	} 
	glEnd(); 
}


- (void) drawCube
{

/*
	GLfloat n[6][3] = {  // Normals for the 6 faces of a cube.
	  {-1.0, 0.0, 0.0}, {0.0, 1.0, 0.0}, {1.0, 0.0, 0.0},
	  {0.0, -1.0, 0.0}, {0.0, 0.0, 1.0}, {0.0, 0.0, -1.0} };
*/
	
	GLfloat n[6][3] = {
		{left - size, bottom, front}, {left, bottom + size, front}, {left + size, bottom, front},
		{left, bottom - size, front}, {left, bottom, front + size}, {left, bottom, front - size}
	};
	
	GLint faces[6][4] = {  /* Vertex indices for the 6 faces of a cube. */
	  {0, 1, 2, 3}, {3, 2, 6, 7}, {7, 6, 5, 4},
	  {4, 5, 1, 0}, {5, 6, 2, 1}, {7, 4, 0, 3} };
	GLfloat v[8][3];  /* Will be filled in with X,Y,Z vertexes. */

	int i;

	for (i = 0; i < 6; i++) {
		glBegin(GL_QUADS);
		glNormal3fv(&n[i][0]);
		glVertex3fv(&v[faces[i][0]][0]);
		glVertex3fv(&v[faces[i][1]][0]);
		glVertex3fv(&v[faces[i][2]][0]);
		glVertex3fv(&v[faces[i][3]][0]);
		glEnd();
	}
}

- (void) drawCubicCurve: (float[]) a: (float[]) b: (float[]) c: (float[]) d: (int) segs: (float) lineWidth
{
	float cx, cy, cz;
	float aa, bb;
	int i;
	
	aa = 1.0f;
	bb = 0.0f;
	
	glColor4f(red, green, blue, alpha);
	glLineWidth(lineWidth);
	glBegin(GL_LINE_STRIP);
	
	for (i = 0; i < segs; i++)
	{
		cx = a[0]*pow(aa,3) + b[0]*pow(aa,2)*bb + c[0]*aa*pow(bb,2) + d[0]*pow(bb,3);
		cy = a[1]*pow(aa,3) + b[1]*pow(aa,2)*bb + c[1]*aa*pow(bb,2) + d[1]*pow(bb,3);
		cz = a[2]*pow(aa,3) + b[2]*pow(aa,2)*bb + c[2]*aa*pow(bb,2) + d[2]*pow(bb,3);
		
		glVertex3f(cx, cy, cz);
		
		aa -= (1.0f / segs);
		bb = 1.0f - aa;
	}
	
	glEnd();
}

-(void) dealloc {
	int i;
	NSArray* names;
	NSString* name;
	
	names = [NSArray arrayWithObjects: @"horizons", @"axial", @"grid", @"mesh", nil ];

	for (i = 0; i < [names count]; i++)
	{
		name = [names objectAtIndex: i];
		[[patches objectForKey: name] release];
	}
	
	[super dealloc];
}

@end

