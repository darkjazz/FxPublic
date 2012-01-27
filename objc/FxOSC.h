/*
 *  FxOSC.h
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

#import <Cocoa/Cocoa.h>
#import "lo/lo.h"
#import "FxDraw.h"
#import "Patch.h"

id refToOscer;

int setting_handler(const char *path, const char *types, lo_arg **argv, 
	int argc, void *data, void *user_data);

int patch_handler(const char *path, const char *types, lo_arg **argv, 
	int argc, void *data, void *user_data);

int reset_handler(const char *path, const char *types, lo_arg **argv, 
	int argc, void *data, void *user_data);

int cell_handler(const char *path, const char *types, lo_arg **argv, int argc,
	void *data, void *user_data);

int poll_handler(const char *path, const char *types, lo_arg **argv, int argc,
	void *data, void *user_data);

void error(int num, const char *m, const char *path);

int quit_handler(const char *path, const char *types, lo_arg **argv, int argc, 
	void *data, void *user_data);

@interface FxOSC : NSObject {
	const char * scIP;
	const char * scPort;
	lo_address addr;
	lo_server_thread thread;
	FxDraw * dw;
	NSMutableArray * pollIndices;
}

- (id) initWithAddress: (const char*) ip: (const char*) port: (FxDraw*) draw;
- (void) sendMessage: (float) avg: (float) sdev: (float) albf: (float) arbf: (float) arbb: 
	(float) albb: (float) altf: (float) artf: (float) artb: (float) altb;
- (void) sendMessage: (NSMutableArray*) states;
- (void) sendTrigger: (int) x: (int) y: (int) z: (float) phase;
- (void) startListener;
- (void) stopListener;
- (float) getAlpha;
- (float) getClear;
- (int) getDone;
- (void) setPatch;

- (void) resetDone;
- (int) getReset;
- (int) getSeed;
- (int) getHabitat;
- (int) getRadius;

- (int) getLeft;
- (int) getBottom;
- (int) getFront;
- (int) getWidth;
- (int) getHeight;
- (int) getDepth;

- (float) getRotateX;
- (float) getRotateY;
- (float) getRotateZ;
- (float) getAngle;

- (float) getTransX;
- (float) getTransY;
- (float) getTransZ;

- (int) getFrameRate;

- (float) add;

- (bool) setCell;
- (bool) setPoll;

- (NSArray*) getWeights;

- (NSArray*) getCell;

- (NSMutableArray*) getPollIndices;

@end
