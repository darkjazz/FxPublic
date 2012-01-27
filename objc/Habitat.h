/*
 *  Habitat.h
 *  Fx
 *
 *  Created by tehis on 31/12/2008.
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


@interface Habitat : NSObject {
	NSMutableArray *indices;
	BOOL includeCell;
	int numNeighbors;
	int range; 
}

////@property (retain) NSMutableArray* indices;
////@property BOOL includeCell;
////@property int numNeighbors;
////@property int range;

-(NSMutableArray*) indices;
-(void) setIndices: (NSMutableArray*) value;

-(BOOL) includeCell;
-(void) setIncludeCell: (BOOL) value;

-(int) numNeighbors;
-(void) setNumNeighbors: (int) value;

-(int) range;
-(void) setRange: (int) value;


-(Habitat*) init;
-(Habitat*) initMoore: (int) radius;
-(Habitat*) initNeumann: (int) radius;
-(void) dealloc;


@end
