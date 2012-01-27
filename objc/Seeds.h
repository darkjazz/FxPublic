/*
 *  Seeds.h
 *  Fx
 *
 *  Created by tehis on 01/01/2009.
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

#import <Cocoa/Cocoa.h>
#include "fxutil.h"


@interface Seeds : NSObject {
	NSMutableArray * indices;
}

-(NSMutableArray *) point: (int) x: (int) y;
-(NSMutableArray *) fillRect: (int) left: (int) top: (int) width: (int) length;
-(NSMutableArray *) rect: (int) left: (int) top: (int) width: (int) length;
-(NSMutableArray *) randCube: (int) left: (int) top: (int) front: (int) width: (int) length: (int) depth;
-(NSMutableArray *) wireCube: (int) left: (int) bottom: (int) front: (int) width: (int) height: (int) depth;
-(NSMutableArray *) fillCube: (int) left: (int) bottom: (int) front: (int) width: (int) height: (int) depth;
-(void) dealloc;

@end
