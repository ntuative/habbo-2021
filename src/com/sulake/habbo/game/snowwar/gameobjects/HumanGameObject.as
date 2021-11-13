package com.sulake.habbo.game.snowwar.gameobjects
{
    import com.sulake.habbo.game.snowwar.Tile;
    import com.sulake.habbo.game.snowwar.utils.Location3D;
    import com.sulake.habbo.game.snowwar.utils.Direction8;
    import com.sulake.habbo.game.snowwar.SnowWarEngine;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.game.snowwar.SnowWarGameStage;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.object.HumanGameObjectData;
    import com.sulake.core.runtime.exceptions.Exception;
    import com.sulake.habbo.game.snowwar.utils.Direction360;
    import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;
    import com.sulake.habbo.game.snowwar.utils._SafeStr_206;
    import com.sulake.habbo.game.snowwar.SnowWarGameArena;
    import com.sulake.habbo.game.snowwar.arena.SynchronizedGameArena;

    public class HumanGameObject extends SnowWarGameObject 
    {

        public static const _SafeStr_2493:int = 534;
        public static const INITIAL_SNOWBALL_COUNT:int = 5;
        public static const MAXIMUM_SNOWBALL_COUNT:int = 5;
        public static const INITIAL_HIT_POINTS:int = 5;
        public static const SNOWBALL_CREATE_TIME:int = 20;
        public static const STUN_TIME:int = 100;
        public static const INVINCIBLE_AFTER_STUN_TIME:int = 60;
        public static const ACTIVITY_STATE_NORMAL:int = 0;
        public static const ACTIVITY_STATE_MAKING_SNOWBALL:int = 1;
        public static const ACTIVITY_STATE_STUNNED:int = 2;
        public static const ACTIVITY_STATE_INVINCIBLE_AFTER_STUN:int = 3;
        public static const SNOWBALL_THROW_INTERVAL:int = 5;
        public static const BOUNDING_DATA:Array = [1600];
        public static const PLAYER_HEIGHT:int = 5000;
        private static const SCORE_ON_KNOCK_DOWN:int = 5;
        private static const SCORE_ON_HIT:int = 1;

        private var _SafeStr_2491:Tile;
        private var _SafeStr_2492:Tile;
        private var _SafeStr_2494:Boolean;
        private var _currentLocation:Location3D = new Location3D(0, 0, 0);
        private var _SafeStr_2490:Location3D = new Location3D(0, 0, 0);
        private var _bodyDirection:Direction8 = Direction8.SE;
        private var _hitPoints:int;
        private var _snowballs:int;
        protected var _SafeStr_2495:int;
        private var _SafeStr_2496:int;
        private var _SafeStr_2497:int;
        private var _score:int;
        private var _team:int;
        private var _SafeStr_2498:int;
        private var _name:String;
        private var _mission:String;
        private var _figure:String;
        private var _sex:String;
        private var _SafeStr_1887:int;
        private var _visualizationMode:int = 0;
        private var _SafeStr_2499:SnowWarEngine;
        private var _SafeStr_2500:Map;

        public function HumanGameObject(_arg_1:SnowWarGameStage, _arg_2:HumanGameObjectData, _arg_3:Boolean, _arg_4:SnowWarEngine)
        {
            super(_arg_2.id, _arg_3);
            _sex = _arg_2.sex;
            _name = _arg_2.name;
            _mission = _arg_2.mission;
            _figure = _arg_2.figure;
            _team = _arg_2.team;
            _SafeStr_1887 = _arg_2.userId;
            _SafeStr_2497 = _arg_2.activityState;
            _SafeStr_2496 = _arg_2.activityTimer;
            _currentLocation.change2DLocation(_arg_2.currentLocationX, _arg_2.currentLocationY);
            _bodyDirection = Direction8.getDirection8(_arg_2.bodyDirection);
            _hitPoints = _arg_2.hitPoints;
            _SafeStr_2490.change2DLocation(_arg_2.moveTargetX, _arg_2.moveTargetY);
            _snowballs = _arg_2.snowBallCount;
            _score = _arg_2.score;
            _SafeStr_2491 = _arg_1.getTileAt(_arg_2.currentTileX, _arg_2.currentTileY);
            _SafeStr_2491.addGameObject(this);
            var _local_5:Tile = _arg_1.getTileAt(_arg_2.nextTileX, _arg_2.nextTileY);
            if (_local_5 != _SafeStr_2491)
            {
                _SafeStr_2492 = _local_5;
                _SafeStr_2492.addGameObject(this);
                _SafeStr_2491.removeOccupyingHuman();
                _SafeStr_2494 = true;
            };
            _SafeStr_2499 = _arg_4;
            _SafeStr_2500 = new Map();
        }

        public function get visualizationMode():int
        {
            return (_visualizationMode);
        }

        public function set visualizationMode(_arg_1:int):void
        {
            _visualizationMode = _arg_1;
        }

        public function get invincible():Boolean
        {
            return (_SafeStr_2497 == 3);
        }

        override public function dispose():void
        {
            super.dispose();
            _sex = "";
            _name = "";
            _mission = "";
            _figure = "";
            _team = 0;
            _SafeStr_1887 = 0;
            _currentLocation = null;
            _bodyDirection = null;
            _SafeStr_2490 = null;
            _snowballs = 0;
            _score = 0;
            _SafeStr_2494 = false;
            _SafeStr_2499 = null;
            _SafeStr_2500 = null;
        }

        override public function get numberOfVariables():int
        {
            return (19);
        }

        override public function getVariable(_arg_1:int):int
        {
            switch (_arg_1)
            {
                case 0:
                    return (5);
                case 1:
                    return (_SafeStr_2501);
                case 2:
                    return (_currentLocation.x);
                case 3:
                    return (_currentLocation.y);
                case 4:
                    return (_SafeStr_2491.fuseLocation[0]);
                case 5:
                    return (_SafeStr_2491.fuseLocation[1]);
                case 6:
                    return (_bodyDirection.intValue());
                case 7:
                    return (_hitPoints);
                case 8:
                    return (_snowballs);
                case 9:
                    return (_SafeStr_2495);
                case 10:
                    return (_SafeStr_2496);
                case 11:
                    return (_SafeStr_2497);
                case 12:
                    return ((_SafeStr_2492 != null) ? _SafeStr_2492.fuseLocation[0] : _SafeStr_2491.fuseLocation[0]);
                case 13:
                    return ((_SafeStr_2492 != null) ? _SafeStr_2492.fuseLocation[1] : _SafeStr_2491.fuseLocation[1]);
                case 14:
                    return (_SafeStr_2490.x);
                case 15:
                    return (_SafeStr_2490.y);
                case 16:
                    return (_score);
                case 17:
                    return (_team);
                case 18:
                    return (_SafeStr_1887);
                default:
                    throw (new Exception(("No such variable:" + _arg_1)));
            };
        }

        public function reinitGhost(_arg_1:HumanGameObject):void
        {
            _currentLocation.change2DLocation(_arg_1._currentLocation.x, _arg_1._currentLocation.y);
            _SafeStr_2491 = _arg_1._SafeStr_2491;
            _bodyDirection = _arg_1._bodyDirection;
            _hitPoints = _arg_1._hitPoints;
            _snowballs = _arg_1._snowballs;
            _SafeStr_2495 = _arg_1._SafeStr_2495;
            _SafeStr_2496 = _arg_1._SafeStr_2496;
            _SafeStr_2497 = _arg_1._SafeStr_2497;
            _SafeStr_2492 = _arg_1._SafeStr_2492;
            _SafeStr_2490.change2DLocation(_arg_1._SafeStr_2490.x, _arg_1._SafeStr_2490.y);
            _score = _arg_1._score;
            _team = _arg_1._team;
            _SafeStr_1887 = _arg_1._SafeStr_1887;
        }

        public function isInGhostDistance(_arg_1:int, _arg_2:Location3D):Boolean
        {
            var _local_3:Location3D = _SafeStr_2500[_arg_1];
            if (_local_3)
            {
                return (_local_3.isInDistance(_arg_2, Tile.TILE_ONEANDHALFWIDTH));
            };
            return (false);
        }

        public function addGhostLocation(_arg_1:int):void
        {
            var _local_2:Location3D = new Location3D(0, 0, 0);
            _local_2.change2DLocation(_currentLocation.x, _currentLocation.y);
            _SafeStr_2500[_arg_1] = _local_2;
        }

        public function removeGhostLocation(_arg_1:int):void
        {
            _SafeStr_2500.remove(_arg_1);
        }

        public function setBodyDirection(_arg_1:Direction8):void
        {
            _bodyDirection = _arg_1;
        }

        override public function get boundingType():int
        {
            return (2);
        }

        override public function get boundingData():Array
        {
            return (BOUNDING_DATA);
        }

        override public function get location3D():Location3D
        {
            return (_currentLocation);
        }

        override public function get direction360():Direction360
        {
            return (null);
        }

        override public function onRemove():void
        {
            if (((_SafeStr_2491) && (_SafeStr_2491.occupyingHuman == this)))
            {
                _SafeStr_2491.removeOccupyingHuman();
            };
            if (((_SafeStr_2492) && (_SafeStr_2492.occupyingHuman == this)))
            {
                _SafeStr_2492.removeOccupyingHuman();
            };
            _SafeStr_2494 = false;
        }

        public function activityTimerTriggered():void
        {
            if (_SafeStr_2497 == 2)
            {
                _hitPoints = 5;
                _SafeStr_2497 = 3;
                _SafeStr_2496 = 60;
                return;
            };
            if (_SafeStr_2497 == 1)
            {
                _snowballs++;
            };
            _SafeStr_2497 = 0;
            _SafeStr_2499.stopWaitingForSnowball(gameObjectId);
        }

        override public function subturn(_arg_1:SynchronizedGameStage):void
        {
            var _local_2:int;
            var _local_3:Direction8;
            var _local_4:SnowWarGameStage = (_arg_1 as SnowWarGameStage);
            if (_SafeStr_2496 > 0)
            {
                if (_SafeStr_2496 == 1)
                {
                    activityTimerTriggered();
                };
                _SafeStr_2496--;
            };
            if (_SafeStr_2498 > 0)
            {
                _SafeStr_2498--;
            };
            if (HabboGamesCom.logEnabled)
            {
                HabboGamesCom.log(((((gameObjectId + " currentTile:") + _SafeStr_2491) + " nextTile:") + _SafeStr_2492));
            };
            if (((canMove()) && (!(_SafeStr_2491 == null))))
            {
                if (_SafeStr_2492 != null)
                {
                    if (HabboGamesCom.logEnabled)
                    {
                        HabboGamesCom.log(((((gameObjectId + " Moving towards next tile:") + _SafeStr_2492) + " _currentLocation:") + _currentLocation));
                    };
                    moveTowardsNextTile();
                }
                else
                {
                    if (!_SafeStr_2491.locationIsInTileRange(_SafeStr_2490))
                    {
                        _local_2 = Direction360.getAngleFromComponents((_SafeStr_2490.x - _SafeStr_2491.location.x), (_SafeStr_2490.y - _SafeStr_2491.location.y));
                        _local_3 = Direction360.direction360ValueToDirection8(_local_2);
                        _SafeStr_2492 = _SafeStr_2491.getTileInDirection(_local_3);
                        if (((_SafeStr_2492 == null) || (!(_SafeStr_2492.canMoveTo(this)))))
                        {
                            if (((!(_SafeStr_2492 == null)) && (!(_SafeStr_2492.canMoveTo(this)))))
                            {
                                if (_SafeStr_2490.equals(_SafeStr_2492.location))
                                {
                                    _SafeStr_2492 = null;
                                    stopMovement();
                                    return;
                                };
                            };
                            _local_3 = _local_3.rotateDirection(-1);
                            _SafeStr_2492 = _SafeStr_2491.getTileInDirection(_local_3);
                            if (((_SafeStr_2492 == null) || (!(_SafeStr_2492.canMoveTo(this)))))
                            {
                                _local_3 = _local_3.rotateDirection(2);
                                _SafeStr_2492 = _SafeStr_2491.getTileInDirection(_local_3);
                                if (((!(_SafeStr_2492 == null)) && (!(_SafeStr_2492.canMoveTo(this)))))
                                {
                                    _SafeStr_2492 = null;
                                };
                            };
                        };
                        if (_SafeStr_2492 != null)
                        {
                            if (!isGhost)
                            {
                                _SafeStr_2491.removeOccupyingHuman();
                                _SafeStr_2492.addGameObject(this);
                            };
                            setBodyDirection(_local_3);
                            moveTowardsNextTile();
                        }
                        else
                        {
                            _SafeStr_2494 = false;
                        };
                        if (HabboGamesCom.logEnabled)
                        {
                            HabboGamesCom.log(((((((((gameObjectId + " Starting to move to next tile in direction360:") + _local_2) + ", nextTile is now ") + _SafeStr_2492) + "_currentLocationn:") + _currentLocation) + ", moveTarget:") + _SafeStr_2490));
                        };
                    }
                    else
                    {
                        _SafeStr_2494 = false;
                    };
                };
            }
            else
            {
                _SafeStr_2494 = false;
            };
        }

        private function moveTowardsNextTile():void
        {
            if (HabboGamesCom.logEnabled)
            {
                HabboGamesCom.log(((((gameObjectId + " [MoveTowardsNextTile], currentX: ") + _currentLocation.x) + " currentY: ") + _currentLocation.y));
            };
            var _local_5:int = _SafeStr_2492.location.x;
            var _local_1:int = _currentLocation.x;
            var _local_2:int = (_local_1 - _local_5);
            if (_local_2 != 0)
            {
                if (_local_2 < 0)
                {
                    if (_local_2 > -(534))
                    {
                        _local_1 = _local_5;
                    }
                    else
                    {
                        _local_1 = (_local_1 + 534);
                    };
                }
                else
                {
                    if (_local_2 < 534)
                    {
                        _local_1 = _local_5;
                    }
                    else
                    {
                        _local_1 = (_local_1 - 534);
                    };
                };
            };
            var _local_3:int = _SafeStr_2492.location.y;
            var _local_6:int = _currentLocation.y;
            var _local_4:int = (_local_6 - _local_3);
            if (_local_4 != 0)
            {
                if (_local_4 < 0)
                {
                    if (_local_4 > -(534))
                    {
                        _local_6 = _local_3;
                    }
                    else
                    {
                        _local_6 = (_local_6 + 534);
                    };
                }
                else
                {
                    if (_local_4 < 534)
                    {
                        _local_6 = _local_3;
                    }
                    else
                    {
                        _local_6 = (_local_6 - 534);
                    };
                };
            };
            if (HabboGamesCom.logEnabled)
            {
                HabboGamesCom.log(((((gameObjectId + " [MoveTowardsNextTile], nextX: ") + _local_1) + " nextY: ") + _local_6));
            };
            _currentLocation.change2DLocation(_local_1, _local_6);
            if (_currentLocation.distanceTo(_SafeStr_2492.location) < _SafeStr_206.javaDiv((534 / 2)))
            {
                _SafeStr_2491 = _SafeStr_2492;
                _SafeStr_2492 = null;
            };
            _SafeStr_2494 = true;
        }

        public function changeMoveTarget(_arg_1:int, _arg_2:int):void
        {
            if (_SafeStr_2497 == 1)
            {
                _SafeStr_2497 = 0;
                _SafeStr_2496 = 0;
                _SafeStr_2499.stopWaitingForSnowball(gameObjectId);
            };
            if (((_SafeStr_2497 == 0) || (_SafeStr_2497 == 3)))
            {
                _SafeStr_2490.change2DLocation(_arg_1, _arg_2);
            };
        }

        public function get currentLocation():Location3D
        {
            return (_currentLocation);
        }

        public function playerIsHitBySnowball(_arg_1:SnowWarGameStage, _arg_2:HumanGameObject, _arg_3:int):void
        {
            if (_SafeStr_2502)
            {
                return;
            };
            if (_team == _arg_2.team)
            {
                return;
            };
            if (_hitPoints > 0)
            {
                if (_hitPoints == 1)
                {
                    playerFallsDown(_arg_3);
                    _arg_2.onKnockDownHuman(_arg_1, this);
                    SnowWarEngine.playSound("HBSTG_snowwar_hit3");
                };
                _hitPoints--;
                _SafeStr_2499.registerHit(this, _arg_2);
            };
        }

        public function onHitHuman(_arg_1:SnowWarGameStage, _arg_2:HumanGameObject):void
        {
            if (((!(_arg_2.isGhost)) && ((!(team == _arg_2.team)) || (SnowWarGameArena(_arg_1.gameArena.getExtension()).isDeathMatch()))))
            {
                addScore(_arg_1.gameArena, 1);
            };
        }

        public function onKnockDownHuman(_arg_1:SnowWarGameStage, _arg_2:HumanGameObject):void
        {
            if (((!(_arg_2.isGhost)) && ((!(team == _arg_2.team)) || (SnowWarGameArena(_arg_1.gameArena.getExtension()).isDeathMatch()))))
            {
                addScore(_arg_1.gameArena, 5);
            };
        }

        public function addScore(_arg_1:SynchronizedGameArena, _arg_2:int):void
        {
            _score = (_score + _arg_2);
            _arg_1.addTeamScore(team, _arg_2);
        }

        public function playerFallsDown(_arg_1:int):void
        {
            _SafeStr_2497 = 2;
            _SafeStr_2496 = 100;
            setBodyDirection(Direction360.direction360ValueToDirection8(_arg_1).oppositeDirection());
            stopMovement();
            _SafeStr_2499.stopWaitingForSnowball(gameObjectId);
        }

        public function stopMovement():void
        {
            if (_SafeStr_2492 == null)
            {
                _SafeStr_2490.changeLocationToLocation(_SafeStr_2491.location);
                _currentLocation.changeLocationToLocation(_SafeStr_2491.location);
            }
            else
            {
                _SafeStr_2491 = _SafeStr_2492;
                _currentLocation.changeLocationToLocation(_SafeStr_2492.location);
                _SafeStr_2490.changeLocationToLocation(_SafeStr_2492.location);
                _SafeStr_2492 = null;
            };
            _SafeStr_2494 = false;
            if (HabboGamesCom.logEnabled)
            {
                HabboGamesCom.log(((((((((("Stopped. dir:" + _bodyDirection) + "_currentTilee:") + _SafeStr_2491) + "_nextTilee:") + _SafeStr_2492) + "_currentLocationn:") + _currentLocation) + "_moveTargett:") + _SafeStr_2490));
            };
        }

        public function getBodyDirection():int
        {
            return (_bodyDirection.intValue());
        }

        public function canThrowSnowballs():Boolean
        {
            return (((_snowballs > 0) && (_SafeStr_2498 < 1)) && ((_SafeStr_2497 == 0) || (_SafeStr_2497 == 3)));
        }

        public function startThrowTimer():void
        {
            _SafeStr_2498 = 5;
        }

        public function throwSnowball(_arg_1:int, _arg_2:int):Boolean
        {
            if (_snowballs < 1)
            {
                return (false);
            };
            stopMovement();
            var _local_4:int = Direction360.getAngleFromComponents((_arg_1 - _currentLocation.x), (_arg_2 - _currentLocation.y));
            var _local_3:int = Direction360.direction360ValueToDirection8(_local_4).intValue();
            setBodyDirection(Direction8.getDirection8(_local_3));
            if (HabboGamesCom.logEnabled)
            {
                HabboGamesCom.log(((((((((((("Turning to:" + _local_3) + " 360 value:") + _local_4) + " target:") + _arg_1) + ",") + _arg_2) + " location:") + _currentLocation.x) + ",") + _currentLocation.y));
            };
            _snowballs--;
            return (true);
        }

        public function canMove():Boolean
        {
            return ((_SafeStr_2497 == 0) || (_SafeStr_2497 == 3));
        }

        public function canMakeSnowballs():Boolean
        {
            return (((_SafeStr_2497 == 0) || (_SafeStr_2497 == 3)) && ((_snowballs < 5) || (isGhost)));
        }

        public function startMakingSnowball():void
        {
            if (canMakeSnowballs())
            {
                _SafeStr_2497 = 1;
                _SafeStr_2496 = 20;
                stopMovement();
            };
        }

        public function getRemainingSnowballCapacity():int
        {
            return (5 - _snowballs);
        }

        public function addSnowballs(_arg_1:int):void
        {
            _snowballs = (_snowballs + _arg_1);
        }

        public function isStunned():Boolean
        {
            return (_SafeStr_2497 == 2);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get mission():String
        {
            return (_mission);
        }

        public function get figure():String
        {
            return (_figure);
        }

        public function get sex():String
        {
            return (_sex);
        }

        public function get score():int
        {
            return (_score);
        }

        public function get team():int
        {
            return (_team);
        }

        public function get snowballs():int
        {
            return (_snowballs);
        }

        public function get hitPoints():int
        {
            return (_hitPoints);
        }

        public function get posture():String
        {
            if (_SafeStr_2498 > 0)
            {
                return ("swthrow");
            };
            switch (_SafeStr_2497)
            {
                case 2:
                    return ("swdieback");
                case 1:
                    return ("swpick");
                default:
                    if (_SafeStr_2494)
                    {
                        return ("swrun");
                    };
                    return ("std");
            };
        }

        public function get action():String
        {
            switch (_SafeStr_2497)
            {
                case 3:
                    return ("figure_dance");
                default:
                    return ("figure_dance");
            };
        }

        public function get parameter():int
        {
            if (_SafeStr_2498 > 1)
            {
                return (1);
            };
            if (_SafeStr_2498 == 1)
            {
                return (0);
            };
            switch (_SafeStr_2497)
            {
                case 3:
                    return (1);
                default:
                    return (0);
            };
        }

        override public function testSnowBallCollision(_arg_1:SnowBallGameObject):Boolean
        {
            if ((((((!(_SafeStr_2502)) && (!(_SafeStr_2497 == 2))) && (!(_SafeStr_2497 == 3))) && (!(_arg_1.throwingHuman == this))) && (super.testSnowBallCollision(_arg_1))))
            {
                return (true);
            };
            return (false);
        }

        override public function onSnowBallHit(_arg_1:SnowWarGameStage, _arg_2:SnowBallGameObject):void
        {
            var _local_3:HumanGameObject = _arg_2.throwingHuman;
            playerIsHitBySnowball(_arg_1, _local_3, _arg_2.direction360.intValue());
            _local_3.onHitHuman(_arg_1, this);
            SnowWarEngine.playSound("HBSTG_snowwar_hit1");
        }

        override public function get collisionHeight():int
        {
            return (5000);
        }

        public function toString():String
        {
            return (((" ref:" + _SafeStr_2501) + "_name:") + _name);
        }


    }
}

