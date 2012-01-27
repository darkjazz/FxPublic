/*
 *  Habitat.m
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

#import "Habitat.h"


@implementation Habitat

//@synthesize indices;
//@synthesize includeCell;
//@synthesize numNeighbors;
//@synthesize range;

-(NSMutableArray*) indices { return indices; }
-(void) setIndices: (NSMutableArray*) value { indices = value; }

-(BOOL) includeCell { return includeCell; }
-(void) setIncludeCell: (BOOL) value { includeCell = value; }

-(int) numNeighbors { return numNeighbors; }
-(void) setNumNeighbors: (int) value { numNeighbors = value; }

-(int) range { return range; }
-(void) setRange: (int) value { range = value; }

-(Habitat*) init {
    self = [super init];
    return self;
}

-(Habitat*) initMoore: (int) radius {
	int size, i, j, k, ix, iy, iz;
	[self init];
	size = radius*2+1;
	numNeighbors = (size*size-1);
	range = radius;
	indices = [NSMutableArray new];
	for (i = 0; i < size; i++) {
		for (j = 0; j < size; j++) {
			for (k = 0; k < size; k++) {
				ix = j - (int)(size / 2);
				iy = i - (int)(size / 2);
				iz = k - (int)(size / 2);
				if (!(iy == 0 && ix == 0 && iz == 0)) {
					[indices addObject: [NSMutableArray arrayWithObjects: [NSNumber numberWithInt:ix], [NSNumber numberWithInt:iy], [NSNumber numberWithInt: iz], nil]];
				}
			}
		}
	}
	return self;
}

-(Habitat*) initNeumann: (int) radius {
	int size;
	[self init];
	size = radius*2+1;
	numNeighbors = 4 * radius;
	range = radius;
	indices = [NSMutableArray new];
	
	[indices addObject: [NSMutableArray arrayWithObjects: [NSNumber numberWithInt:-1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]];
	[indices addObject: [NSMutableArray arrayWithObjects: [NSNumber numberWithInt:0], [NSNumber numberWithInt:-1], [NSNumber numberWithInt:0], nil]];
	[indices addObject: [NSMutableArray arrayWithObjects: [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:-1], nil]];
	[indices addObject: [NSMutableArray arrayWithObjects: [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], nil]];
	[indices addObject: [NSMutableArray arrayWithObjects: [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], nil]];
	[indices addObject: [NSMutableArray arrayWithObjects: [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]];
	
//	for (i = 0; i < size; i++) {
//		for (j = 0; j < size; j++) {
//			for (k = 0; k < size; k++)
//			{
//				if (i == range || j == range || k == range) {
//					[indices addObject: [NSMutableArray arrayWithObjects: [NSNumber numberWithInt:i], [NSNumber numberWithInt:j], [NSNumber numberWithInt:k], nil]];
//				}
//			}
//		}
//	}
	return self;
}

-(void) dealloc {
	[indices release];
	[super dealloc];
}

@end
