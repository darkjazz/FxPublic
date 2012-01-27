//
/*
 *  Cell.m
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

#import "Cell.h"


@implementation Cell

//@synthesize state;
//@synthesize lastState;
//@synthesize direction;
//@synthesize habitat;

-(float) state { return state; }
-(void) setState: (float) value { state = value; }

-(float) lastState { return lastState; }
-(void) setLastState: (float) value { lastState = value; }

-(float) direction { return direction; }
-(void) setDirection: (float) value { direction = value; }

-(float) phase { return phase; }
-(void) setPhase: (float) value { phase = value; }

-(float) velocity { return velocity; }
-(void) setVelocity: (float) value { velocity = value; }

-(int) coordX { return coordX; }
-(int) coordY { return coordY; }
-(int) coordZ { return coordZ; }

-(NSMutableArray*) habitat { return habitat; }
-(void) setHabitat: (NSMutableArray*) value { habitat = value; }

-(Cell*) init: (float) iState {
	self = [super init];
	state = iState;
	return self;
}

-(Cell*) initme: (float) iState: (int) cx: (int) cy: (int) cz
{
	self = [super init];
	state = iState;
	coordX = cx;
	coordY = cy;
	coordZ = cz;
	return self;
}

-(float) next: (float) add: (int) frameRateRatio {
	float val, avg;
	int i;
	avg = 0;
	if (habitat) {
		val = 0;
		for (i = 0; i < [habitat count]; i++)
		{
			val += [[habitat objectAtIndex: i] lastState];
		}
		avg = val / [habitat count];
		avg += add;
		if (avg > 1.0f) { avg -= 1.0f; }		

		velocity = (avg - lastState) / frameRateRatio;		
		[self setState: avg];
	}
	return avg;
}

-(float) next: (float) add: (NSArray*) weights: (int) frameRateRatio {
	float avg, wsum;
	int i;
	if ([weights count] != [habitat count])
	{
		return [self next: add: frameRateRatio];
	}
	else
	{
		avg = wsum = 0.0f;
		for (i=0;i<[habitat count];i++)
		{
			avg += [[habitat objectAtIndex: i] lastState] * [[weights objectAtIndex: i] floatValue];
			wsum += [[weights objectAtIndex: i] floatValue];
		}
		avg = avg / wsum;
		
//		if (avg > 0.5f) { avg += add; }
//		else { avg -= add; }
		avg += add;
		if (avg > 1.0f) { avg -= 1.0f; }		
		
		velocity = (avg - lastState) / frameRateRatio;	
//		avg = wrapf(avg, 0.0f, 1.0f);
		[self setState: avg];
		
		return avg;
	}
}

-(void) updatePhase {
	phase = wrapf(phase + velocity, 0.0f, 1.0f);
}

-(void) dealloc {
	[super dealloc];
}

@end
