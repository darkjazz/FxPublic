/*
 *  Seeds.m
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

#import "Seeds.h"


@implementation Seeds

-(NSMutableArray *) point: (int) x: (int) y {
	
	indices = [NSMutableArray new];
	[indices addObject: [[NSArray new] initWithObjects: 
		[NSNumber numberWithInt: x], 
		[NSNumber numberWithInt: y], 
		[NSNumber numberWithFloat: 1.0]
	]];
	
	return indices;
}

-(NSMutableArray *) fillRect: (int) left: (int) top: (int) width: (int) length {
	int i, j;
	indices = [NSMutableArray new];
	for (i = 0; i < width; i++) {
		for (j = 0; j < length; j++) {
			[
				indices addObject: [
					[NSArray new] initWithObjects: 
						[NSNumber numberWithInt: left + i], 
						[NSNumber numberWithInt: top + j], 
						[NSNumber numberWithFloat: 1.0]
				]
			];
		}
	}
	
	return indices;
}

-(NSMutableArray *) rect: (int) left: (int) top: (int) width: (int) length {
	int i, j;
	indices = [NSMutableArray new];
	for (i = 0; i < width; i++) {
		for (j = 0; j < length; j++) {
			if (i == 0 || j == 0 || i == (width - 1) || j == (length - 1)) {
				[
					indices addObject:
						[NSArray arrayWithObjects: 
							[NSNumber numberWithInt: left + i], 
							[NSNumber numberWithInt: top + j], 
							[NSNumber numberWithFloat: 1.0],
							nil
					]
				];
			}
		}
	}
	
	return indices;
}

-(NSMutableArray *) wireCube: (int) left: (int) top: (int) front: (int) width: (int) height: (int) depth {
	int i, j, k;
	indices = [NSMutableArray new];
	for (i = left; i < left + width; i++)
	{
		for (j = top; j < top + height; j++)
		{
			for (k = front; k < front + depth; k++)
			{
				if (i == left || j == top || k == front || i == (width - 1) || j == (height - 1) || k == (depth - 1))
				{
					[
					indices addObject:
						[NSArray arrayWithObjects: 
							[NSNumber numberWithInt: i],
							[NSNumber numberWithInt: j],
							[NSNumber numberWithInt: k],							
							[NSNumber numberWithFloat: 1.0f],
							nil
						]
					];
				}
			}
		}
	}
	
	return indices;

}

-(NSMutableArray *) randCube: (int) left: (int) top: (int) front: (int) width: (int) length: (int) depth {
	int i, j, k;
	indices = [NSMutableArray new];
	initrand();
 	for (i = 0; i < width; i++) {
		for (j = 0; j < length; j++) {
			for (k = 0; k < depth; k++)
			{
				[indices addObject: [NSArray arrayWithObjects: 
								[NSNumber numberWithInt: left + i], 
								[NSNumber numberWithInt: top + j], 
								[NSNumber numberWithInt: front + k],
								[NSNumber numberWithFloat: randf()],
								nil
						]
				];
			}
		}
	}
	
	return indices;

}

-(NSMutableArray *) fillCube: (int) left: (int) top: (int) front: (int) width: (int) length: (int) depth {
	int i, j, k;
	indices = [NSMutableArray new];
	initrand();
 	for (i = 0; i < width; i++) {
		for (j = 0; j < length; j++) {
			for (k = 0; k < depth; k++)
			{
				[indices addObject: [NSArray arrayWithObjects: 
								[NSNumber numberWithInt: left + i], 
								[NSNumber numberWithInt: top + j], 
								[NSNumber numberWithInt: front + k],
								[NSNumber numberWithFloat: 1.0f],
								nil
						]
				];
			}
		}
	}
	
	return indices;

}


- (void) dealloc
{
    [indices release];
    [super dealloc];
}

@end
