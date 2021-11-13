package com.sulake.habbo.utils.animation
{
    import flash.events.EventDispatcher;
    import __AS3__.vec.Vector;
    import flash.events.Event;

    public class Tween extends EventDispatcher implements IAnimatable 
    {

        private static const HINT_MARKER:String = "#";

        private static var _SafeStr_4347:Vector.<Tween> = new Vector.<Tween>(0);

        private const REMOVE_FROM_JUGGLER:String = "REMOVE_FROM_JUGGLER";

        private var _target:Object;
        private var _transitionFunc:Function;
        private var _transition:String;
        private var _SafeStr_4348:Vector.<String>;
        private var _SafeStr_4349:Vector.<Number>;
        private var _SafeStr_4350:Vector.<Number>;
        private var _SafeStr_4351:Vector.<Function>;
        private var _onStart:Function;
        private var _onUpdate:Function;
        private var _onRepeat:Function;
        private var _onComplete:Function;
        private var _onStartArgs:Array;
        private var _onUpdateArgs:Array;
        private var _onRepeatArgs:Array;
        private var _onCompleteArgs:Array;
        private var _totalTime:Number;
        private var _currentTime:Number;
        private var _progress:Number;
        private var _delay:Number;
        private var _roundToInt:Boolean;
        private var _nextTween:Tween;
        private var _repeatCount:int;
        private var _repeatDelay:Number;
        private var _reverse:Boolean;
        private var _SafeStr_4352:int;

        public function Tween(_arg_1:Object, _arg_2:Number, _arg_3:Object="linear")
        {
            reset(_arg_1, _arg_2, _arg_3);
        }

        internal static function getPropertyHint(_arg_1:String):String
        {
            if (((!(_arg_1.indexOf("color") == -1)) || (!(_arg_1.indexOf("Color") == -1))))
            {
                return ("rgb");
            };
            var _local_2:int = _arg_1.indexOf("#");
            if (_local_2 != -1)
            {
                return (_arg_1.substr((_local_2 + 1)));
            };
            return (null);
        }

        internal static function getPropertyName(_arg_1:String):String
        {
            var _local_2:int = _arg_1.indexOf("#");
            if (_local_2 != -1)
            {
                return (_arg_1.substring(0, _local_2));
            };
            return (_arg_1);
        }

        internal static function fromPool(_arg_1:Object, _arg_2:Number, _arg_3:Object="linear"):Tween
        {
            if (_SafeStr_4347.length)
            {
                return (_SafeStr_4347.pop().reset(_arg_1, _arg_2, _arg_3));
            };
            return (new Tween(_arg_1, _arg_2, _arg_3));
        }

        internal static function toPool(_arg_1:Tween):void
        {
            var _local_2:* = null;
            _arg_1._onComplete = _local_2;
            _arg_1._onRepeat = _local_2;
            _arg_1._onUpdate = _local_2;
            _arg_1._onStart = _local_2;
            _local_2 = null;
            _arg_1._onCompleteArgs = _local_2;
            _arg_1._onRepeatArgs = _local_2;
            _arg_1._onUpdateArgs = _local_2;
            _arg_1._onStartArgs = _local_2;
            _arg_1._target = null;
            _arg_1._transitionFunc = null;
            _SafeStr_4347.push(_arg_1);
        }


        public function reset(_arg_1:Object, _arg_2:Number, _arg_3:Object="linear"):Tween
        {
            _target = _arg_1;
            _currentTime = 0;
            _totalTime = Math.max(0.0001, _arg_2);
            _progress = 0;
            _delay = (_repeatDelay = 0);
            _onStart = (_onUpdate = (_onRepeat = (_onComplete = null)));
            _onStartArgs = (_onUpdateArgs = (_onRepeatArgs = (_onCompleteArgs = null)));
            _roundToInt = (_reverse = false);
            _repeatCount = 1;
            _SafeStr_4352 = -1;
            _nextTween = null;
            if ((_arg_3 is String))
            {
                this.transition = (_arg_3 as String);
            }
            else
            {
                if ((_arg_3 is Function))
                {
                    this.transitionFunc = (_arg_3 as Function);
                }
                else
                {
                    throw (new ArgumentError("Transition must be either a string or a function"));
                };
            };
            if (_SafeStr_4348)
            {
                _SafeStr_4348.length = 0;
            }
            else
            {
                _SafeStr_4348 = new Vector.<String>(0);
            };
            if (_SafeStr_4349)
            {
                _SafeStr_4349.length = 0;
            }
            else
            {
                _SafeStr_4349 = new Vector.<Number>(0);
            };
            if (_SafeStr_4350)
            {
                _SafeStr_4350.length = 0;
            }
            else
            {
                _SafeStr_4350 = new Vector.<Number>(0);
            };
            if (_SafeStr_4351)
            {
                _SafeStr_4351.length = 0;
            }
            else
            {
                _SafeStr_4351 = new Vector.<Function>(0);
            };
            return (this);
        }

        public function animate(_arg_1:String, _arg_2:Number):void
        {
            if (_target == null)
            {
                return;
            };
            var _local_3:int = _SafeStr_4348.length;
            var _local_4:Function = getUpdateFuncFromProperty(_arg_1);
            _SafeStr_4348[_local_3] = getPropertyName(_arg_1);
            _SafeStr_4349[_local_3] = NaN;
            _SafeStr_4350[_local_3] = _arg_2;
            _SafeStr_4351[_local_3] = _local_4;
        }

        public function scaleTo(_arg_1:Number):void
        {
            animate("scaleX", _arg_1);
            animate("scaleY", _arg_1);
        }

        public function moveTo(_arg_1:Number, _arg_2:Number):void
        {
            animate("x", _arg_1);
            animate("y", _arg_2);
        }

        public function fadeTo(_arg_1:Number):void
        {
            animate("alpha", _arg_1);
        }

        public function rotateTo(_arg_1:Number, _arg_2:String="rad"):void
        {
            animate(("rotation#" + _arg_2), _arg_1);
        }

        public function advanceTime(_arg_1:Number):void
        {
            var _local_6:int;
            var _local_7:Function;
            var _local_5:Function;
            var _local_8:Array;
            if (((_arg_1 == 0) || ((_repeatCount == 1) && (_currentTime == _totalTime))))
            {
                return;
            };
            var _local_3:Number = _currentTime;
            var _local_2:Number = (_totalTime - _currentTime);
            var _local_10:Number = ((_arg_1 > _local_2) ? (_arg_1 - _local_2) : 0);
            _currentTime = (_currentTime + _arg_1);
            if (_currentTime <= 0)
            {
                return;
            };
            if (_currentTime > _totalTime)
            {
                _currentTime = _totalTime;
            };
            if ((((_SafeStr_4352 < 0) && (_local_3 <= 0)) && (_currentTime > 0)))
            {
                _SafeStr_4352++;
                if (_onStart != null)
                {
                    _onStart.apply(this, _onStartArgs);
                };
            };
            var _local_11:Number = (_currentTime / _totalTime);
            var _local_9:Boolean = ((_reverse) && ((_SafeStr_4352 % 2) == 1));
            var _local_4:int = _SafeStr_4349.length;
            _progress = ((_local_9) ? _transitionFunc((1 - _local_11)) : _transitionFunc(_local_11));
            _local_6 = 0;
            while (_local_6 < _local_4)
            {
                if (_SafeStr_4349[_local_6] != _SafeStr_4349[_local_6])
                {
                    _SafeStr_4349[_local_6] = (_target[_SafeStr_4348[_local_6]] as Number);
                };
                _local_7 = (_SafeStr_4351[_local_6] as Function);
                (_local_7(_SafeStr_4348[_local_6], _SafeStr_4349[_local_6], _SafeStr_4350[_local_6]));
                _local_6++;
            };
            if (_onUpdate != null)
            {
                _onUpdate.apply(this, _onUpdateArgs);
            };
            if (((_local_3 < _totalTime) && (_currentTime >= _totalTime)))
            {
                if (((_repeatCount == 0) || (_repeatCount > 1)))
                {
                    _currentTime = -(_repeatDelay);
                    _SafeStr_4352++;
                    if (_repeatCount > 1)
                    {
                        _repeatCount--;
                    };
                    if (_onRepeat != null)
                    {
                        _onRepeat.apply(this, _onRepeatArgs);
                    };
                }
                else
                {
                    _local_5 = _onComplete;
                    _local_8 = _onCompleteArgs;
                    dispatchEvent(new Event("REMOVE_FROM_JUGGLER"));
                    if (_local_5 != null)
                    {
                        _local_5.apply(this, _local_8);
                    };
                    if (_currentTime == 0)
                    {
                        _local_10 = 0;
                    };
                };
            };
            if (_local_10)
            {
                advanceTime(_local_10);
            };
        }

        private function getUpdateFuncFromProperty(_arg_1:String):Function
        {
            var _local_3:Function;
            var _local_2:String = getPropertyHint(_arg_1);
            switch (_local_2)
            {
                case null:
                    _local_3 = updateStandard;
                    break;
                case "rgb":
                    _local_3 = updateRgb;
                    break;
                case "rad":
                    _local_3 = updateRad;
                    break;
                case "deg":
                    _local_3 = updateDeg;
                    break;
                default:
                    (trace("[Starling] Ignoring unknown property hint:", _local_2));
                    _local_3 = updateStandard;
            };
            return (_local_3);
        }

        private function updateStandard(_arg_1:String, _arg_2:Number, _arg_3:Number):void
        {
            var _local_4:Number = (_arg_2 + (_progress * (_arg_3 - _arg_2)));
            if (_roundToInt)
            {
                _local_4 = Math.round(_local_4);
            };
            _target[_arg_1] = _local_4;
        }

        private function updateRgb(_arg_1:String, _arg_2:Number, _arg_3:Number):void
        {
            var _local_11:uint = _arg_2;
            var _local_6:uint = _arg_3;
            var _local_13:uint = ((_local_11 >> 24) & 0xFF);
            var _local_17:uint = ((_local_11 >> 16) & 0xFF);
            var _local_7:uint = ((_local_11 >> 8) & 0xFF);
            var _local_10:uint = (_local_11 & 0xFF);
            var _local_9:uint = ((_local_6 >> 24) & 0xFF);
            var _local_16:uint = ((_local_6 >> 16) & 0xFF);
            var _local_5:uint = ((_local_6 >> 8) & 0xFF);
            var _local_8:uint = (_local_6 & 0xFF);
            var _local_14:uint = (_local_13 + ((_local_9 - _local_13) * _progress));
            var _local_4:uint = (_local_17 + ((_local_16 - _local_17) * _progress));
            var _local_15:uint = (_local_7 + ((_local_5 - _local_7) * _progress));
            var _local_12:uint = (_local_10 + ((_local_8 - _local_10) * _progress));
            _target[_arg_1] = ((((_local_14 << 24) | (_local_4 << 16)) | (_local_15 << 8)) | _local_12);
        }

        private function updateRad(_arg_1:String, _arg_2:Number, _arg_3:Number):void
        {
            updateAngle(3.14159265358979, _arg_1, _arg_2, _arg_3);
        }

        private function updateDeg(_arg_1:String, _arg_2:Number, _arg_3:Number):void
        {
            updateAngle(180, _arg_1, _arg_2, _arg_3);
        }

        private function updateAngle(_arg_1:Number, _arg_2:String, _arg_3:Number, _arg_4:Number):void
        {
            while (Math.abs((_arg_4 - _arg_3)) > _arg_1)
            {
                if (_arg_3 < _arg_4)
                {
                    _arg_4 = (_arg_4 - (2 * _arg_1));
                }
                else
                {
                    _arg_4 = (_arg_4 + (2 * _arg_1));
                };
            };
            updateStandard(_arg_2, _arg_3, _arg_4);
        }

        public function getEndValue(_arg_1:String):Number
        {
            var _local_2:int = _SafeStr_4348.indexOf(_arg_1);
            if (_local_2 == -1)
            {
                throw (new ArgumentError((("The property '" + _arg_1) + "' is not animated")));
            };
            return (_SafeStr_4350[_local_2] as Number);
        }

        public function get isComplete():Boolean
        {
            return ((_currentTime >= _totalTime) && (_repeatCount == 1));
        }

        public function get target():Object
        {
            return (_target);
        }

        public function get transition():String
        {
            return (_transition);
        }

        public function set transition(_arg_1:String):void
        {
            _transition = _arg_1;
            _transitionFunc = Transitions.getTransition(_arg_1);
            if (_transitionFunc == null)
            {
                throw (new ArgumentError(("Invalid transiton: " + _arg_1)));
            };
        }

        public function get transitionFunc():Function
        {
            return (_transitionFunc);
        }

        public function set transitionFunc(_arg_1:Function):void
        {
            _transition = "custom";
            _transitionFunc = _arg_1;
        }

        public function get totalTime():Number
        {
            return (_totalTime);
        }

        public function get currentTime():Number
        {
            return (_currentTime);
        }

        public function get progress():Number
        {
            return (_progress);
        }

        public function get delay():Number
        {
            return (_delay);
        }

        public function set delay(_arg_1:Number):void
        {
            _currentTime = ((_currentTime + _delay) - _arg_1);
            _delay = _arg_1;
        }

        public function get repeatCount():int
        {
            return (_repeatCount);
        }

        public function set repeatCount(_arg_1:int):void
        {
            _repeatCount = _arg_1;
        }

        public function get repeatDelay():Number
        {
            return (_repeatDelay);
        }

        public function set repeatDelay(_arg_1:Number):void
        {
            _repeatDelay = _arg_1;
        }

        public function get reverse():Boolean
        {
            return (_reverse);
        }

        public function set reverse(_arg_1:Boolean):void
        {
            _reverse = _arg_1;
        }

        public function get roundToInt():Boolean
        {
            return (_roundToInt);
        }

        public function set roundToInt(_arg_1:Boolean):void
        {
            _roundToInt = _arg_1;
        }

        public function get onStart():Function
        {
            return (_onStart);
        }

        public function set onStart(_arg_1:Function):void
        {
            _onStart = _arg_1;
        }

        public function get onUpdate():Function
        {
            return (_onUpdate);
        }

        public function set onUpdate(_arg_1:Function):void
        {
            _onUpdate = _arg_1;
        }

        public function get onRepeat():Function
        {
            return (_onRepeat);
        }

        public function set onRepeat(_arg_1:Function):void
        {
            _onRepeat = _arg_1;
        }

        public function get onComplete():Function
        {
            return (_onComplete);
        }

        public function set onComplete(_arg_1:Function):void
        {
            _onComplete = _arg_1;
        }

        public function get onStartArgs():Array
        {
            return (_onStartArgs);
        }

        public function set onStartArgs(_arg_1:Array):void
        {
            _onStartArgs = _arg_1;
        }

        public function get onUpdateArgs():Array
        {
            return (_onUpdateArgs);
        }

        public function set onUpdateArgs(_arg_1:Array):void
        {
            _onUpdateArgs = _arg_1;
        }

        public function get onRepeatArgs():Array
        {
            return (_onRepeatArgs);
        }

        public function set onRepeatArgs(_arg_1:Array):void
        {
            _onRepeatArgs = _arg_1;
        }

        public function get onCompleteArgs():Array
        {
            return (_onCompleteArgs);
        }

        public function set onCompleteArgs(_arg_1:Array):void
        {
            _onCompleteArgs = _arg_1;
        }

        public function get nextTween():Tween
        {
            return (_nextTween);
        }

        public function set nextTween(_arg_1:Tween):void
        {
            _nextTween = _arg_1;
        }


    }
}

