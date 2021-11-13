package com.sulake.habbo.room.object.visualization.furniture
{
    import flash.geom.Vector3D;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;

    public class FurnitureParticleSystemParticle 
    {

        private var _x:Number;
        private var _y:Number;
        private var _z:Number;
        private var _lastX:Number;
        private var _lastY:Number;
        private var _lastZ:Number;
        private var _hasMoved:Boolean = false;
        private var _direction:Vector3D;
        private var _age:int = 0;
        private var _lifeTime:int;
        private var _isEmitter:Boolean = false;
        private var _fade:Boolean = false;
        private var _fadeTime:Number;
        private var _alphaMultiplier:Number = 1;
        private var _SafeStr_748:Array;


        public function get fade():Boolean
        {
            return (_fade);
        }

        public function get alphaMultiplier():Number
        {
            return (_alphaMultiplier);
        }

        public function get direction():Vector3D
        {
            return (_direction);
        }

        public function get age():int
        {
            return (_age);
        }

        public function init(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Vector3D, _arg_5:Number, _arg_6:Number, _arg_7:int, _arg_8:Boolean=false, _arg_9:Array=null, _arg_10:Boolean=false):void
        {
            _x = _arg_1;
            _y = _arg_2;
            _z = _arg_3;
            _direction = new Vector3D(_arg_4.x, _arg_4.y, _arg_4.z);
            _direction.scaleBy(_arg_5);
            _lastX = (_x - (_direction.x * _arg_6));
            _lastY = (_y - (_direction.y * _arg_6));
            _lastZ = (_z - (_direction.z * _arg_6));
            _age = 0;
            _hasMoved = false;
            _lifeTime = _arg_7;
            _isEmitter = _arg_8;
            _SafeStr_748 = _arg_9;
            _fade = _arg_10;
            _alphaMultiplier = 1;
            _fadeTime = (0.5 + (Math.random() * 0.5));
        }

        public function update():void
        {
            _age++;
            if (_age == _lifeTime)
            {
                ignite();
            };
            if (_fade)
            {
                if ((_age / _lifeTime) > _fadeTime)
                {
                    _alphaMultiplier = ((_lifeTime - _age) / (_lifeTime * (1 - _fadeTime)));
                };
            };
        }

        public function getAsset():IGraphicAsset
        {
            if (((_SafeStr_748) && (_SafeStr_748.length > 0)))
            {
                return (_SafeStr_748[(_age % _SafeStr_748.length)]);
            };
            return (null);
        }

        protected function ignite():void
        {
        }

        public function get isEmitter():Boolean
        {
            return (_isEmitter);
        }

        public function get isAlive():Boolean
        {
            return (_age <= _lifeTime);
        }

        public function dispose():void
        {
            _direction = null;
        }

        public function get x():Number
        {
            return (_x);
        }

        public function get y():Number
        {
            return (_y);
        }

        public function get z():Number
        {
            return (_z);
        }

        public function set x(_arg_1:Number):void
        {
            _x = _arg_1;
        }

        public function set y(_arg_1:Number):void
        {
            _y = _arg_1;
        }

        public function set z(_arg_1:Number):void
        {
            _z = _arg_1;
        }

        public function get lastX():Number
        {
            return (_lastX);
        }

        public function set lastX(_arg_1:Number):void
        {
            _hasMoved = true;
            _lastX = _arg_1;
        }

        public function get lastY():Number
        {
            return (_lastY);
        }

        public function set lastY(_arg_1:Number):void
        {
            _hasMoved = true;
            _lastY = _arg_1;
        }

        public function get lastZ():Number
        {
            return (_lastZ);
        }

        public function set lastZ(_arg_1:Number):void
        {
            _hasMoved = true;
            _lastZ = _arg_1;
        }

        public function get hasMoved():Boolean
        {
            return (_hasMoved);
        }

        public function toString():String
        {
            return ([_x, _y, _z].toString());
        }

        public function copy(_arg_1:FurnitureParticleSystemParticle, _arg_2:Number):void
        {
            _x = (_arg_1._x * _arg_2);
            _y = (_arg_1._y * _arg_2);
            _z = (_arg_1._z * _arg_2);
            _lastX = (_arg_1._lastX * _arg_2);
            _lastY = (_arg_1._lastY * _arg_2);
            _lastZ = (_arg_1._lastZ * _arg_2);
            _hasMoved = _arg_1.hasMoved;
            _direction = _arg_1._direction;
            _age = _arg_1._age;
            _lifeTime = _arg_1._lifeTime;
            _isEmitter = _arg_1._isEmitter;
            _fade = _arg_1._fade;
            _fadeTime = _arg_1._fadeTime;
            _alphaMultiplier = _arg_1._alphaMultiplier;
        }


    }
}

