package com.sulake.habbo.utils.animation
{
    import __AS3__.vec.Vector;
    import flash.events.EventDispatcher;
    import flash.events.Event;

    public class Juggler implements IAnimatable 
    {

        public static const REMOVE_FROM_JUGGLER:String = "REMOVE_FROM_JUGGLER";

        private var _objects:Vector.<IAnimatable>;
        private var _elapsedTime:Number;

        public function Juggler()
        {
            _elapsedTime = 0;
            _objects = new Vector.<IAnimatable>(0);
        }

        public function add(_arg_1:IAnimatable):void
        {
            var _local_2:EventDispatcher;
            if (((_arg_1) && (_objects.indexOf(_arg_1) == -1)))
            {
                _objects[_objects.length] = _arg_1;
                _local_2 = (_arg_1 as EventDispatcher);
                if (_local_2)
                {
                    _local_2.addEventListener("REMOVE_FROM_JUGGLER", onRemove);
                };
            };
        }

        public function contains(_arg_1:IAnimatable):Boolean
        {
            return (!(_objects.indexOf(_arg_1) == -1));
        }

        public function remove(_arg_1:IAnimatable):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            var _local_3:EventDispatcher = (_arg_1 as EventDispatcher);
            if (_local_3)
            {
                _local_3.removeEventListener("REMOVE_FROM_JUGGLER", onRemove);
            };
            var _local_2:int = _objects.indexOf(_arg_1);
            if (_local_2 != -1)
            {
                _objects[_local_2] = null;
            };
        }

        public function removeTweens(_arg_1:Object):void
        {
            var _local_3:int;
            var _local_2:Tween;
            if (_arg_1 == null)
            {
                return;
            };
            _local_3 = (_objects.length - 1);
            while (_local_3 >= 0)
            {
                _local_2 = (_objects[_local_3] as Tween);
                if (((_local_2) && (_local_2.target == _arg_1)))
                {
                    _local_2.removeEventListener("REMOVE_FROM_JUGGLER", onRemove);
                    _objects[_local_3] = null;
                };
                _local_3--;
            };
        }

        public function containsTweens(_arg_1:Object):Boolean
        {
            var _local_3:int;
            var _local_2:Tween;
            if (_arg_1 == null)
            {
                return (false);
            };
            _local_3 = (_objects.length - 1);
            while (_local_3 >= 0)
            {
                _local_2 = (_objects[_local_3] as Tween);
                if (((_local_2) && (_local_2.target == _arg_1)))
                {
                    return (true);
                };
                _local_3--;
            };
            return (false);
        }

        public function purge():void
        {
            var _local_1:int;
            var _local_2:EventDispatcher;
            _local_1 = (_objects.length - 1);
            while (_local_1 >= 0)
            {
                _local_2 = (_objects[_local_1] as EventDispatcher);
                if (_local_2)
                {
                    _local_2.removeEventListener("REMOVE_FROM_JUGGLER", onRemove);
                };
                _objects[_local_1] = null;
                _local_1--;
            };
        }

        public function delayCall(_arg_1:Function, _arg_2:Number, ... _args):IAnimatable
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_4:DelayedCall = DelayedCall.fromPool(_arg_1, _arg_2, _args);
            _local_4.addEventListener("REMOVE_FROM_JUGGLER", onPooledDelayedCallComplete);
            add(_local_4);
            return (_local_4);
        }

        public function repeatCall(_arg_1:Function, _arg_2:Number, _arg_3:int=0, ... _args):IAnimatable
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_5:DelayedCall = DelayedCall.fromPool(_arg_1, _arg_2, _args);
            _local_5.repeatCount = _arg_3;
            _local_5.addEventListener("REMOVE_FROM_JUGGLER", onPooledDelayedCallComplete);
            add(_local_5);
            return (_local_5);
        }

        private function onPooledDelayedCallComplete(_arg_1:Event):void
        {
            DelayedCall.toPool((_arg_1.target as DelayedCall));
        }

        public function tween(_arg_1:Object, _arg_2:Number, _arg_3:Object):IAnimatable
        {
            var _local_6:Object;
            if (_arg_1 == null)
            {
                throw (new ArgumentError("target must not be null"));
            };
            var _local_4:Tween = Tween.fromPool(_arg_1, _arg_2);
            for (var _local_5:String in _arg_3)
            {
                _local_6 = _arg_3[_local_5];
                if (_local_4.hasOwnProperty(_local_5))
                {
                    _local_4[_local_5] = _local_6;
                }
                else
                {
                    if (_arg_1.hasOwnProperty(Tween.getPropertyName(_local_5)))
                    {
                        _local_4.animate(_local_5, (_local_6 as Number));
                    }
                    else
                    {
                        throw (new ArgumentError(("Invalid property: " + _local_5)));
                    };
                };
            };
            _local_4.addEventListener("REMOVE_FROM_JUGGLER", onPooledTweenComplete);
            add(_local_4);
            return (_local_4);
        }

        private function onPooledTweenComplete(_arg_1:Event):void
        {
            Tween.toPool((_arg_1.target as Tween));
        }

        public function advanceTime(_arg_1:Number):void
        {
            var _local_2:int;
            var _local_5:IAnimatable;
            var _local_4:int = _objects.length;
            var _local_3:int;
            _elapsedTime = (_elapsedTime + _arg_1);
            if (_local_4 == 0)
            {
                return;
            };
            _local_2 = 0;
            while (_local_2 < _local_4)
            {
                _local_5 = _objects[_local_2];
                if (_local_5)
                {
                    if (_local_3 != _local_2)
                    {
                        _objects[_local_3] = _local_5;
                        _objects[_local_2] = null;
                    };
                    _local_5.advanceTime(_arg_1);
                    _local_3++;
                };
                _local_2++;
            };
            if (_local_3 != _local_2)
            {
                _local_4 = _objects.length;
                while (_local_2 < _local_4)
                {
                    _objects[_local_3++] = _objects[_local_2++];
                };
                _objects.length = _local_3;
            };
        }

        private function onRemove(_arg_1:Event):void
        {
            remove((_arg_1.target as IAnimatable));
            var _local_2:Tween = (_arg_1.target as Tween);
            if (((_local_2) && (_local_2.isComplete)))
            {
                add(_local_2.nextTween);
            };
        }

        public function get elapsedTime():Number
        {
            return (_elapsedTime);
        }

        protected function get objects():Vector.<IAnimatable>
        {
            return (_objects);
        }


    }
}