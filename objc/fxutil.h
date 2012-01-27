/*
 *  fxutil.h
 *  Fx
 *
 *  Created by tehis on 21/01/2009.
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

#include "stdlib.h"
#include "math.h"

void initrand();
float map(float, float, float);
int randint(int, int);
float randf();
float randfloat(float, float);
int xmod(int, int);
int wrapi(int, int, int);
float wrapf(float, float, float);
int isEven(int);
float xmodf(float, float);
