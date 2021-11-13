package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Point;
    import com.sulake.habbo.avatar.actions.IActiveActionData;
    import com.sulake.habbo.avatar.alias.AssetAliasCollection;
    import com.sulake.habbo.avatar.cache.AvatarImageCache;
    import com.sulake.habbo.avatar.animation.IAvatarDataContainer;
    import flash.display.BitmapData;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.avatar.actions.ActiveActionData;
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import com.sulake.habbo.avatar.animation.IAnimationLayerData;
    import com.sulake.habbo.avatar.structure.AvatarCanvas;
    import com.sulake.habbo.utils.BitmapHelper;
    import flash.geom.Rectangle;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.actions.ActionDefinition;
    import com.sulake.habbo.avatar.actions.IActionDefinition;
    import com.sulake.habbo.avatar.animation.Animation;
    import flash.utils.getTimer;
    import flash.filters.ColorMatrixFilter;

    public class AvatarImage implements IAvatarImage, IDisposable, IAvatarEffectListener 
    {

        private static const CHANNELS_EQUAL:String = "CHANNELS_EQUAL";
        private static const CHANNELS_UNIQUE:String = "CHANNELS_UNIQUE";
        private static const CHANNELS_RED:String = "CHANNELS_RED";
        private static const CHANNELS_GREEN:String = "CHANNELS_GREEN";
        private static const CHANNELS_BLUE:String = "CHANNELS_BLUE";
        private static const CHANNELS_SATURATED:String = "CHANNELS_SATURATED";
        private static const DEFAULT_ACTION:String = "Default";
        private static const DEFAULT_DIR:int = 2;
        private static const DEFAULT_AVATAR_SET:String = "full";
        private static const DEFAULT_POINT:Point = new Point(0, 0);

        protected var _SafeStr_462:AvatarStructure;
        protected var _SafeStr_1266:String;
        protected var _mainDirection:int;
        protected var _headDirection:int;
        protected var _mainAction:IActiveActionData;
        protected var _SafeStr_1381:Boolean;
        protected var _SafeStr_1245:Array = [];
        protected var _assets:AssetAliasCollection;
        protected var _cache:AvatarImageCache;
        protected var _SafeStr_1382:AvatarFigureContainer;
        protected var _SafeStr_1383:IAvatarDataContainer;
        protected var _SafeStr_701:Array = [];
        protected var _SafeStr_1384:BitmapData;
        private var _defaultAction:IActiveActionData;
        private var _SafeStr_1385:int = 0;
        private var _directionOffset:int = 0;
        private var _SafeStr_1386:Boolean;
        private var _SafeStr_1387:Vector.<ISpriteDataContainer>;
        private var _SafeStr_1388:Boolean;
        private var _animationHasResetOnToggle:Boolean = false;
        private var _SafeStr_1389:Boolean = false;
        private var _SafeStr_1390:Array;
        private var _SafeStr_1391:String;
        private var _SafeStr_1392:String;
        private var _fullImageCache:Map;
        protected var _SafeStr_1393:Boolean = false;
        private var _useFullImageCache:Boolean;
        private var _SafeStr_1394:int = -1;
        private var _SafeStr_1395:int;
        private var _SafeStr_1396:Array = [];
        private var _cachedBodyPartsDirection:int = -1;
        private var _SafeStr_1397:String = null;
        private var _SafeStr_1398:String = null;
        private var _SafeStr_1399:EffectAssetDownloadManager;
        private var _SafeStr_1400:IAvatarEffectListener;

        public function AvatarImage(_arg_1:AvatarStructure, _arg_2:AssetAliasCollection, _arg_3:AvatarFigureContainer, _arg_4:String, _arg_5:EffectAssetDownloadManager, _arg_6:IAvatarEffectListener)
        {
            _SafeStr_1386 = true;
            _SafeStr_1399 = _arg_5;
            _SafeStr_462 = _arg_1;
            _assets = _arg_2;
            _SafeStr_1266 = _arg_4;
            _SafeStr_1400 = _arg_6;
            var _local_7:Boolean;
            if (_SafeStr_1266 == null)
            {
                _SafeStr_1266 = "h";
            }
            else
            {
                if (_SafeStr_1266 == "h_50")
                {
                    _local_7 = true;
                    _SafeStr_1266 = "sh";
                };
            };
            if (_arg_3 == null)
            {
                _arg_3 = new AvatarFigureContainer("hr-893-45.hd-180-2.ch-210-66.lg-270-82.sh-300-91.wa-2007-.ri-1-");
                Logger.log("Using default avatar figure");
            };
            _SafeStr_1382 = _arg_3;
            _cache = new AvatarImageCache(_SafeStr_462, this, _assets, _SafeStr_1266, _local_7);
            setDirection("full", 2);
            _SafeStr_701 = [];
            _defaultAction = new ActiveActionData("std");
            _defaultAction.definition = _SafeStr_462.getActionDefinition("Default");
            resetActions();
            _fullImageCache = new Map();
        }

        public function getServerRenderData():Array
        {
            getAvatarPartsForCamera("full");
            return (_cache.getServerRenderData());
        }

        public function dispose():void
        {
            if (!_SafeStr_1381)
            {
                _SafeStr_462 = null;
                _assets = null;
                _mainAction = null;
                _SafeStr_1382 = null;
                _SafeStr_1383 = null;
                _SafeStr_701 = null;
                if (_SafeStr_1384)
                {
                    _SafeStr_1384.dispose();
                };
                if (_cache)
                {
                    _cache.dispose();
                    _cache = null;
                };
                if (_fullImageCache)
                {
                    for each (var _local_1:BitmapData in _fullImageCache)
                    {
                        _local_1.dispose();
                    };
                    _fullImageCache.dispose();
                    _fullImageCache = null;
                };
                _SafeStr_1384 = null;
                _SafeStr_1245 = null;
                _SafeStr_1381 = true;
            };
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_1381);
        }

        public function getFigure():IAvatarFigureContainer
        {
            return (_SafeStr_1382);
        }

        public function getScale():String
        {
            return (_SafeStr_1266);
        }

        public function getPartColor(_arg_1:String):IPartColor
        {
            return (_SafeStr_462.getPartColor(_SafeStr_1382, _arg_1));
        }

        public function setDirection(_arg_1:String, _arg_2:int):void
        {
            _arg_2 = (_arg_2 + _directionOffset);
            if (_arg_2 < 0)
            {
                _arg_2 = (7 + (_arg_2 + 1));
            };
            if (_arg_2 > 7)
            {
                _arg_2 = (_arg_2 - (7 + 1));
            };
            if (_SafeStr_462.isMainAvatarSet(_arg_1))
            {
                _mainDirection = _arg_2;
            };
            if (((_arg_1 == "head") || (_arg_1 == "full")))
            {
                if (((_arg_1 == "head") && (isHeadTurnPreventedByAction())))
                {
                    _arg_2 = _mainDirection;
                };
                _headDirection = _arg_2;
            };
            _cache.setDirection(_arg_1, _arg_2);
            _SafeStr_1386 = true;
        }

        public function setDirectionAngle(_arg_1:String, _arg_2:int):void
        {
            var _local_3:int;
            _local_3 = int((_arg_2 / 45));
            setDirection(_arg_1, _local_3);
        }

        public function getSprites():Vector.<ISpriteDataContainer>
        {
            return (_SafeStr_1387);
        }

        public function getCanvasOffsets():Array
        {
            return (_SafeStr_1245);
        }

        public function getLayerData(_arg_1:ISpriteDataContainer):IAnimationLayerData
        {
            return (_SafeStr_462.getBodyPartData(_arg_1.animation.id, _SafeStr_1385, _arg_1.id));
        }

        public function updateAnimationByFrames(_arg_1:int=1):void
        {
            _SafeStr_1385 = (_SafeStr_1385 + _arg_1);
            _SafeStr_1386 = true;
        }

        public function resetAnimationFrameCounter():void
        {
            _SafeStr_1385 = 0;
            _SafeStr_1386 = true;
        }

        private function getFullImageCacheKey():String
        {
            var _local_1:IActiveActionData;
            var _local_2:int;
            if (!_useFullImageCache)
            {
                return (null);
            };
            if (((_SafeStr_1390.length == 1) && (_mainDirection == _headDirection)))
            {
                if (_mainAction == "std")
                {
                    return (_mainDirection + _SafeStr_1392);
                };
                return ((_mainDirection + _SafeStr_1392) + (_SafeStr_1385 % 4));
            };
            if (_SafeStr_1390.length == 2)
            {
                for each (_local_1 in _SafeStr_1390)
                {
                    if (((_local_1.actionType == "fx") && ((((_local_1.actionParameter == "33") || (_local_1.actionParameter == "34")) || (_local_1.actionParameter == "35")) || (_local_1.actionParameter == "36"))))
                    {
                        return ((_mainDirection + _SafeStr_1392) + 0);
                    };
                    if (((_local_1.actionType == "fx") && ((_local_1.actionParameter == "38") || (_local_1.actionParameter == "39"))))
                    {
                        _local_2 = (_SafeStr_1385 % 11);
                        return ((((_mainDirection + "_") + _headDirection) + _SafeStr_1392) + _local_2);
                    };
                };
            };
            return (null);
        }

        private function getBodyParts(_arg_1:String, _arg_2:String, _arg_3:int):Array
        {
            if ((((!(_arg_3 == _cachedBodyPartsDirection)) || (!(_arg_2 == _SafeStr_1397))) || (!(_arg_1 == _SafeStr_1398))))
            {
                _cachedBodyPartsDirection = _arg_3;
                _SafeStr_1397 = _arg_2;
                _SafeStr_1398 = _arg_1;
                _SafeStr_1396 = _SafeStr_462.getBodyParts(_arg_1, _arg_2, _arg_3);
            };
            return (_SafeStr_1396);
        }

        public function getAvatarPartsForCamera(_arg_1:String):void
        {
            var _local_4:String;
            var _local_2:AvatarImageBodyPartContainer;
            var _local_6:int;
            if (_mainAction == null)
            {
                return;
            };
            var _local_5:AvatarCanvas = _SafeStr_462.getCanvas(_SafeStr_1266, _mainAction.definition.geometryType);
            if (_local_5 == null)
            {
                return;
            };
            var _local_3:Array = getBodyParts(_arg_1, _mainAction.definition.geometryType, _mainDirection);
            _local_6 = (_local_3.length - 1);
            while (_local_6 >= 0)
            {
                _local_4 = _local_3[_local_6];
                _local_2 = _cache.getImageContainer(_local_4, _SafeStr_1385, true);
                _local_6--;
            };
        }

        public function getImage(_arg_1:String, _arg_2:Boolean, _arg_3:Number=1):BitmapData
        {
            var _local_12:String;
            var _local_4:AvatarImageBodyPartContainer;
            var _local_10:BitmapData;
            var _local_8:Point;
            var _local_11:int;
            var _local_7:BitmapData;
            if (!_SafeStr_1386)
            {
                return (_SafeStr_1384);
            };
            if (_mainAction == null)
            {
                return (null);
            };
            if (!_SafeStr_1389)
            {
                endActionAppends();
            };
            var _local_9:String = getFullImageCacheKey();
            if (_local_9 != null)
            {
                if (getFullImage(_local_9))
                {
                    _SafeStr_1386 = false;
                    if (_arg_2)
                    {
                        return ((getFullImage(_local_9) as BitmapData).clone());
                    };
                    _SafeStr_1384 = (getFullImage(_local_9) as BitmapData);
                    _SafeStr_1393 = true;
                    return (_SafeStr_1384);
                };
            };
            var _local_6:AvatarCanvas = _SafeStr_462.getCanvas(_SafeStr_1266, _mainAction.definition.geometryType);
            if (_local_6 == null)
            {
                return (null);
            };
            if ((((_SafeStr_1393) || (_SafeStr_1384 == null)) || ((!(_SafeStr_1384.width == _local_6.width)) || (!(_SafeStr_1384.height == _local_6.height)))))
            {
                if (((!(_SafeStr_1384 == null)) && (!(_SafeStr_1393))))
                {
                    _SafeStr_1384.dispose();
                };
                _SafeStr_1384 = new BitmapData(_local_6.width, _local_6.height, true, 0);
                _SafeStr_1393 = false;
            };
            var _local_5:Array = getBodyParts(_arg_1, _mainAction.definition.geometryType, _mainDirection);
            _SafeStr_1384.lock();
            _SafeStr_1384.fillRect(_SafeStr_1384.rect, 0);
            var _local_13:Boolean = true;
            _local_11 = (_local_5.length - 1);
            while (_local_11 >= 0)
            {
                _local_12 = _local_5[_local_11];
                _local_4 = _cache.getImageContainer(_local_12, _SafeStr_1385);
                if (_local_4)
                {
                    _local_13 = ((_local_13) && (_local_4.isCacheable));
                    _local_10 = _local_4.image;
                    _local_8 = _local_4.regPoint.add(_local_6.offset);
                    if (((_local_10) && (_local_8)))
                    {
                        _local_8 = _local_8.add(_local_6.regPoint);
                        _SafeStr_1384.copyPixels(_local_10, _local_10.rect, _local_8, null, null, true);
                    };
                };
                _local_11--;
            };
            _SafeStr_1384.unlock();
            _SafeStr_1386 = false;
            if (_SafeStr_1383 != null)
            {
                if (_SafeStr_1383.paletteIsGrayscale)
                {
                    _local_7 = convertToGrayscale(_SafeStr_1384);
                    if (_SafeStr_1384)
                    {
                        _SafeStr_1384.dispose();
                    };
                    _SafeStr_1384 = _local_7;
                    _SafeStr_1384.paletteMap(_SafeStr_1384, _SafeStr_1384.rect, DEFAULT_POINT, _SafeStr_1383.reds, [], []);
                }
                else
                {
                    _SafeStr_1384.copyChannel(_SafeStr_1384, _SafeStr_1384.rect, DEFAULT_POINT, 2, 8);
                };
            };
            if (((!(_local_9 == null)) && (_local_13)))
            {
                cacheFullImage(_local_9, _SafeStr_1384.clone());
            };
            if (_arg_3 != 1)
            {
                _SafeStr_1384 = BitmapHelper.resampleBitmapData(_SafeStr_1384, _arg_3);
            };
            if (((_SafeStr_1384) && (_arg_2)))
            {
                return (_SafeStr_1384.clone());
            };
            return (_SafeStr_1384);
        }

        public function getCroppedImage(_arg_1:String, _arg_2:Number=1):BitmapData
        {
            var _local_11:String;
            var _local_3:AvatarImageBodyPartContainer;
            var _local_8:BitmapData;
            var _local_7:Point;
            var _local_9:int;
            if (_mainAction == null)
            {
                return (null);
            };
            if (!_SafeStr_1389)
            {
                endActionAppends();
            };
            var _local_6:AvatarCanvas = _SafeStr_462.getCanvas(_SafeStr_1266, _mainAction.definition.geometryType);
            if (_local_6 == null)
            {
                return (null);
            };
            var _local_4:BitmapData = new BitmapData(_local_6.width, _local_6.height, true, 0xFFFFFF);
            var _local_5:Array = _SafeStr_462.getBodyParts(_arg_1, _mainAction.definition.geometryType, _mainDirection);
            var _local_10:Rectangle;
            var _local_13:Rectangle = new Rectangle();
            _local_9 = (_local_5.length - 1);
            while (_local_9 >= 0)
            {
                _local_11 = _local_5[_local_9];
                _local_3 = _cache.getImageContainer(_local_11, _SafeStr_1385);
                if (_local_3 != null)
                {
                    _local_8 = _local_3.image;
                    if (_local_8 == null)
                    {
                        _local_4.dispose();
                        return (null);
                    };
                    _local_7 = _local_3.regPoint;
                    _local_4.copyPixels(_local_8, _local_8.rect, _local_7, null, null, true);
                    _local_13.x = _local_7.x;
                    _local_13.y = _local_7.y;
                    _local_13.width = _local_8.width;
                    _local_13.height = _local_8.height;
                    if (_local_10 == null)
                    {
                        _local_10 = _local_13.clone();
                    }
                    else
                    {
                        _local_10 = _local_10.union(_local_13);
                    };
                };
                _local_9--;
            };
            if (_local_10 == null)
            {
                _local_10 = new Rectangle(0, 0, 1, 1);
            };
            var _local_12:BitmapData = new BitmapData(_local_10.width, _local_10.height, true, 0xFFFFFF);
            _local_12.copyPixels(_local_4, _local_10, DEFAULT_POINT, null, null, true);
            _local_4.dispose();
            if (_arg_2 != 1)
            {
                _local_12 = BitmapHelper.resampleBitmapData(_local_12, _arg_2);
            };
            return (_local_12);
        }

        protected function getFullImage(_arg_1:String):BitmapData
        {
            return (_fullImageCache[_arg_1]);
        }

        protected function cacheFullImage(_arg_1:String, _arg_2:BitmapData):void
        {
            if (_fullImageCache.getValue(_arg_1))
            {
                (_fullImageCache.getValue(_arg_1) as BitmapData).dispose();
                _fullImageCache.remove(_arg_1);
            };
            _fullImageCache[_arg_1] = _arg_2;
        }

        public function getAsset(_arg_1:String):BitmapDataAsset
        {
            return (_assets.getAssetByName(_arg_1) as BitmapDataAsset);
        }

        public function getDirection():int
        {
            return (_mainDirection);
        }

        public function initActionAppends():void
        {
            _SafeStr_701 = [];
            _SafeStr_1389 = false;
            _SafeStr_1392 = "";
            _useFullImageCache = false;
        }

        public function endActionAppends():void
        {
            var _local_1:ActiveActionData;
            if (sortActions())
            {
                for each (_local_1 in _SafeStr_1390)
                {
                    if (_local_1.actionType == "fx")
                    {
                        if (!_SafeStr_1399.isReady(parseInt(_local_1.actionParameter)))
                        {
                            _SafeStr_1399.loadEffectData(parseInt(_local_1.actionParameter), this);
                        };
                    };
                };
                resetActions();
                setActionsToParts();
            };
        }

        public function appendAction(_arg_1:String, ... _args):Boolean
        {
            var _local_3:String;
            var _local_4:ActionDefinition;
            _SafeStr_1389 = false;
            if (((!(_args == null)) && (_args.length > 0)))
            {
                _local_3 = _args[0];
            };
            switch (_arg_1)
            {
                case "posture":
                    switch (_local_3)
                    {
                        case "lay":
                            if (_mainDirection == 0)
                            {
                                setDirection("full", 4);
                            }
                            else
                            {
                                setDirection("full", 2);
                            };
                        case "mv":
                            _useFullImageCache = true;
                        case "std":
                            _useFullImageCache = true;
                        case "swim":
                        case "float":
                        case "sit":
                        case "swrun":
                        case "swdiefront":
                        case "swdieback":
                        case "swpick":
                        case "swthrow":
                            addActionData(_local_3);
                            break;
                        default:
                            errorThis(("appendAction() >> UNKNOWN POSTURE TYPE: " + _local_3));
                    };
                    break;
                case "gest":
                    switch (_local_3)
                    {
                        case "agr":
                        case "sad":
                        case "sml":
                        case "srp":
                            addActionData(_local_3);
                            break;
                        default:
                            errorThis(("appendAction() >> UNKNOWN GESTURE TYPE: " + _local_3));
                    };
                    break;
                case "fx":
                    if (((((((_local_3 == "33") || (_local_3 == "34")) || (_local_3 == "35")) || (_local_3 == "36")) || (_local_3 == "38")) || (_local_3 == "39")))
                    {
                        _useFullImageCache = true;
                    };
                case "dance":
                case "talk":
                case "wave":
                case "Sleep":
                case "sign":
                case "respect":
                case "blow":
                case "laugh":
                case "cry":
                case "idle":
                case "sbollie":
                case "sb360":
                case "ridejump":
                    addActionData(_arg_1, _local_3);
                    break;
                case "cri":
                case "usei":
                    _local_4 = _SafeStr_462.getActionDefinitionWithState(_arg_1);
                    if (_local_4 != null)
                    {
                        logThis(("appendAction:" + [_local_3, "->", _local_4.getParameterValue(_local_3)]));
                        _local_3 = _local_4.getParameterValue(_local_3);
                    };
                    addActionData(_arg_1, _local_3);
                    break;
                default:
                    errorThis(("appendAction() >> UNKNOWN ACTION TYPE: " + _arg_1));
            };
            return (true);
        }

        protected function addActionData(_arg_1:String, _arg_2:String=""):void
        {
            var _local_4:ActiveActionData;
            var _local_3:int;
            if (_SafeStr_701 == null)
            {
                _SafeStr_701 = [];
            };
            _local_3 = 0;
            while (_local_3 < _SafeStr_701.length)
            {
                _local_4 = _SafeStr_701[_local_3];
                if (((_local_4.actionType == _arg_1) && (_local_4.actionParameter == _arg_2)))
                {
                    return;
                };
                _local_3++;
            };
            _SafeStr_701.push(new ActiveActionData(_arg_1, _arg_2, _SafeStr_1385));
        }

        public function isAnimating():Boolean
        {
            return ((_SafeStr_1388) || (_SafeStr_1395 > 1));
        }

        private function resetActions():Boolean
        {
            _animationHasResetOnToggle = false;
            _SafeStr_1388 = false;
            _SafeStr_1387 = new Vector.<ISpriteDataContainer>(0);
            _SafeStr_1383 = null;
            _directionOffset = 0;
            _SafeStr_462.removeDynamicItems(this);
            _mainAction = _defaultAction;
            _mainAction.definition = _defaultAction.definition;
            resetBodyPartCache(_defaultAction);
            return (true);
        }

        private function isHeadTurnPreventedByAction():Boolean
        {
            var _local_2:IActionDefinition;
            var _local_1:ActiveActionData;
            if (_SafeStr_1390 == null)
            {
                return (false);
            };
            for each (_local_1 in _SafeStr_1390)
            {
                _local_2 = _SafeStr_462.getActionDefinitionWithState(_local_1.actionType);
                if (!(((_local_1.actionType == "Sleep") && (_mainAction)) && (!(_mainAction.actionType == "lay"))))
                {
                    if (((!(_local_2 == null)) && (_local_2.getPreventHeadTurn(_local_1.actionParameter))))
                    {
                        return (true);
                    };
                };
            };
            return (false);
        }

        private function sortActions():Boolean
        {
            var _local_5:Boolean;
            var _local_1:Boolean;
            var _local_4:ActiveActionData;
            var _local_2:int;
            var _local_3:Boolean;
            _SafeStr_1392 = "";
            _SafeStr_1390 = _SafeStr_462.sortActions(_SafeStr_701);
            _SafeStr_1395 = _SafeStr_462.maxFrames(_SafeStr_1390);
            if (_SafeStr_1390 == null)
            {
                _SafeStr_1245 = new Array(0, 0, 0);
                if (_SafeStr_1391 != "")
                {
                    _local_3 = true;
                    _SafeStr_1391 = "";
                };
            }
            else
            {
                _SafeStr_1245 = _SafeStr_462.getCanvasOffsets(_SafeStr_1390, _SafeStr_1266, _mainDirection);
                for each (_local_4 in _SafeStr_1390)
                {
                    _SafeStr_1392 = (_SafeStr_1392 + (_local_4.actionType + _local_4.actionParameter));
                    if (_local_4.actionType == "fx")
                    {
                        _local_2 = parseInt(_local_4.actionParameter);
                        if (_SafeStr_1394 != _local_2)
                        {
                            _local_5 = true;
                        };
                        _SafeStr_1394 = _local_2;
                        _local_1 = true;
                    };
                };
                if (!_local_1)
                {
                    if (_SafeStr_1394 > -1)
                    {
                        _local_5 = true;
                    };
                    _SafeStr_1394 = -1;
                };
                if (_local_5)
                {
                    _cache.disposeInactiveActions(0);
                };
                if (_SafeStr_1391 != _SafeStr_1392)
                {
                    _local_3 = true;
                    _SafeStr_1391 = _SafeStr_1392;
                };
            };
            _SafeStr_1389 = true;
            return (_local_3);
        }

        private function setActionsToParts():void
        {
            var _local_2:ActiveActionData;
            var _local_6:Animation;
            var _local_1:Array;
            var _local_4:String;
            var _local_5:Vector.<ISpriteDataContainer> = undefined;
            if (_SafeStr_1390 == null)
            {
                return;
            };
            var _local_3:int = getTimer();
            var _local_7:Array = [];
            for each (_local_2 in _SafeStr_1390)
            {
                _local_7.push(_local_2.actionType);
            };
            for each (_local_2 in _SafeStr_1390)
            {
                if ((((_local_2) && (_local_2.definition)) && (_local_2.definition.isAnimation)))
                {
                    _local_6 = _SafeStr_462.getAnimation(((_local_2.definition.state + ".") + _local_2.actionParameter));
                    if (((_local_6) && (_local_6.hasOverriddenActions())))
                    {
                        _local_1 = _local_6.overriddenActionNames();
                        if (_local_1)
                        {
                            for each (_local_4 in _local_1)
                            {
                                if (_local_7.indexOf(_local_4) >= 0)
                                {
                                    _local_2.overridingAction = _local_6.overridingAction(_local_4);
                                };
                            };
                        };
                    };
                    if (((_local_6) && (_local_6.resetOnToggle)))
                    {
                        _animationHasResetOnToggle = true;
                    };
                };
            };
            for each (_local_2 in _SafeStr_1390)
            {
                if (!((!(_local_2)) || (!(_local_2.definition))))
                {
                    if (((_local_2.definition.isAnimation) && (_local_2.actionParameter == "")))
                    {
                        _local_2.actionParameter = "1";
                    };
                    setActionToParts(_local_2, _local_3);
                    if (_local_2.definition.isAnimation)
                    {
                        _SafeStr_1388 = _local_2.definition.isAnimated(_local_2.actionParameter);
                        _local_6 = _SafeStr_462.getAnimation(((_local_2.definition.state + ".") + _local_2.actionParameter));
                        if (_local_6 != null)
                        {
                            _local_5 = _local_6.spriteData;
                            if (_local_5)
                            {
                                _SafeStr_1387 = _SafeStr_1387.concat(_local_5);
                            };
                            if (_local_6.hasDirectionData())
                            {
                                _directionOffset = _local_6.directionData.offset;
                            };
                            if (_local_6.hasAvatarData())
                            {
                                _SafeStr_1383 = _local_6.avatarData;
                            };
                        };
                    };
                };
            };
        }

        private function setActionToParts(_arg_1:IActiveActionData, _arg_2:int):void
        {
            if (((_arg_1 == null) || (_arg_1.definition == null)))
            {
                return;
            };
            if (_arg_1.definition.assetPartDefinition == "")
            {
                return;
            };
            if (_arg_1.definition.isMain)
            {
                _mainAction = _arg_1;
                _cache.setGeometryType(_arg_1.definition.geometryType);
            };
            _cache.setAction(_arg_1, _arg_2);
            _SafeStr_1386 = true;
        }

        private function resetBodyPartCache(_arg_1:IActiveActionData):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            if (_arg_1.definition.assetPartDefinition == "")
            {
                return;
            };
            if (_arg_1.definition.isMain)
            {
                _mainAction = _arg_1;
                _cache.setGeometryType(_arg_1.definition.geometryType);
            };
            _cache.resetBodyPartCache(_arg_1);
            _SafeStr_1386 = true;
        }

        public function get avatarSpriteData():IAvatarDataContainer
        {
            return (_SafeStr_1383);
        }

        private function convertToGrayscale(_arg_1:BitmapData, _arg_2:String="CHANNELS_EQUAL"):BitmapData
        {
            var _local_5:Number = 0.33;
            var _local_8:Number = 0.33;
            var _local_6:Number = 0.33;
            var _local_4:Number = 1;
            switch (_arg_2)
            {
                case "CHANNELS_UNIQUE":
                    _local_5 = 0.3;
                    _local_8 = 0.59;
                    _local_6 = 0.11;
                    break;
                case "CHANNELS_RED":
                    _local_5 = 1;
                    _local_8 = 0;
                    _local_6 = 0;
                    break;
                case "CHANNELS_GREEN":
                    _local_5 = 0;
                    _local_8 = 1;
                    _local_6 = 0;
                    break;
                case "CHANNELS_BLUE":
                    _local_5 = 0;
                    _local_8 = 0;
                    _local_6 = 1;
                    break;
                case "CHANNELS_DESATURATED":
                    _local_5 = 0.3086;
                    _local_8 = 0.6094;
                    _local_6 = 0.082;
            };
            var _local_7:Array = [_local_5, _local_8, _local_6, 0, 0, _local_5, _local_8, _local_6, 0, 0, _local_5, _local_8, _local_6, 0, 0, 0, 0, 0, 1, 0];
            var _local_3:ColorMatrixFilter = new ColorMatrixFilter(_local_7);
            var _local_9:BitmapData = new BitmapData(_arg_1.width, _arg_1.height, _arg_1.transparent, 0xFFFFFFFF);
            _local_9.copyPixels(_arg_1, _arg_1.rect, DEFAULT_POINT, null, null, false);
            _local_9.applyFilter(_local_9, _local_9.rect, DEFAULT_POINT, _local_3);
            return (_local_9);
        }

        private function errorThis(_arg_1:String):void
        {
        }

        private function logThis(_arg_1:String):void
        {
        }

        public function isPlaceholder():Boolean
        {
            return (false);
        }

        public function forceActionUpdate():void
        {
            _SafeStr_1391 = "";
        }

        public function get animationHasResetOnToggle():Boolean
        {
            return (_animationHasResetOnToggle);
        }

        public function get mainAction():String
        {
            return (_mainAction.actionType);
        }

        public function avatarEffectReady(_arg_1:int):void
        {
            if (_arg_1 == _SafeStr_1394)
            {
                resetActions();
                setActionsToParts();
                _animationHasResetOnToggle = true;
                _SafeStr_1386 = true;
                if (_SafeStr_1400)
                {
                    _SafeStr_1400.avatarEffectReady(_arg_1);
                };
            };
        }


    }
}

