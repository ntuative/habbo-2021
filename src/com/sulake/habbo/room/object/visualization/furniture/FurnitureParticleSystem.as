package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.core.utils.Map;
    import flash.display.BitmapData;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import flash.geom.Point;
    import flash.geom.Vector3D;

    public class FurnitureParticleSystem 
    {

        private var _emitters:Map;
        private var _visualization:AnimatedFurnitureVisualization;
        private var _SafeStr_3316:int;
        private var _SafeStr_3317:int;
        private var _offsetY:int;
        private var _SafeStr_3318:FurnitureParticleSystemEmitter;
        private var _SafeStr_1267:BitmapData;
        private var _SafeStr_3319:IRoomObjectSprite;
        private var _SafeStr_3320:Boolean = false;
        private var _SafeStr_2291:int = 0;
        private var _SafeStr_2292:int = 0;
        private var _SafeStr_3321:Number = 1;
        private var _SafeStr_3322:BitmapData;
        private var _SafeStr_3315:ColorTransform;
        private var _SafeStr_3323:ColorTransform;
        private var _SafeStr_3324:Matrix;
        private var _SafeStr_3325:Matrix;
        private var _SafeStr_1230:Number = 1;
        private var _bgColor:uint = 0xFF000000;

        public function FurnitureParticleSystem(_arg_1:AnimatedFurnitureVisualization)
        {
            _emitters = new Map();
            _visualization = _arg_1;
            _SafeStr_3315 = new ColorTransform();
            _SafeStr_3315.alphaMultiplier = 1;
            _SafeStr_3323 = new ColorTransform();
            _SafeStr_3324 = new Matrix();
            _SafeStr_3325 = new Matrix();
        }

        public function dispose():void
        {
            for each (var _local_1:FurnitureParticleSystemEmitter in _emitters)
            {
                _local_1.dispose();
            };
            _emitters = null;
            if (_SafeStr_1267)
            {
                _SafeStr_1267.dispose();
                _SafeStr_1267 = null;
            };
            if (_SafeStr_3322)
            {
                _SafeStr_3322.dispose();
                _SafeStr_3322 = null;
            };
            _SafeStr_3315 = null;
            _SafeStr_3323 = null;
            _SafeStr_3324 = null;
            _SafeStr_3325 = null;
        }

        public function reset():void
        {
            if (_SafeStr_3318)
            {
                _SafeStr_3318.reset();
            };
            _SafeStr_3318 = null;
            _SafeStr_3320 = false;
            updateCanvas();
        }

        public function setAnimation(_arg_1:int):void
        {
            if (_SafeStr_3318)
            {
                _SafeStr_3318.reset();
            };
            _SafeStr_3318 = _emitters[_arg_1];
            _SafeStr_3320 = false;
            updateCanvas();
        }

        private function updateCanvas():void
        {
            if (!_SafeStr_3318)
            {
                return;
            };
            if (_SafeStr_3317 >= 0)
            {
                _SafeStr_3319 = _visualization.getSprite(_SafeStr_3317);
                if (((_SafeStr_3319) && (_SafeStr_3319.asset)))
                {
                    if (((_SafeStr_3319.width <= 1) || (_SafeStr_3319.height <= 1)))
                    {
                        return;
                    };
                    if (((_SafeStr_1267) && ((!(_SafeStr_1267.width == _SafeStr_3319.width)) || (!(_SafeStr_1267.height == _SafeStr_3319.height)))))
                    {
                        _SafeStr_1267 = null;
                    };
                    if (_SafeStr_1267 == null)
                    {
                        _SafeStr_1267 = _SafeStr_3319.asset.clone();
                        if (_SafeStr_3315.alphaMultiplier != 1)
                        {
                            _SafeStr_3322 = new BitmapData(_SafeStr_1267.width, _SafeStr_1267.height, true, _bgColor);
                        };
                    };
                    _SafeStr_2291 = -(_SafeStr_3319.offsetX);
                    _SafeStr_2292 = -(_SafeStr_3319.offsetY);
                    _SafeStr_3319.asset = _SafeStr_1267;
                };
                if (_SafeStr_1267)
                {
                    _SafeStr_1267.fillRect(_SafeStr_1267.rect, _bgColor);
                };
                if (_SafeStr_3322)
                {
                    _SafeStr_3322.fillRect(_SafeStr_3322.rect, _bgColor);
                };
            };
        }

        public function getSpriteYOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            if (((_SafeStr_3318) && (_SafeStr_3318.roomObjectSpriteId == _arg_3)))
            {
                return (_SafeStr_3318.y * _SafeStr_3321);
            };
            return (0);
        }

        public function controlsSprite(_arg_1:int):Boolean
        {
            if (_SafeStr_3318)
            {
                return (_SafeStr_3318.roomObjectSpriteId == _arg_1);
            };
            return (false);
        }

        public function updateSprites():void
        {
            if (((!(_SafeStr_3318)) || (!(_SafeStr_3319))))
            {
                return;
            };
            if (((_SafeStr_1267) && (!(_SafeStr_3319.asset == _SafeStr_1267))))
            {
                _SafeStr_3319.asset = _SafeStr_1267;
                _SafeStr_3319.asset.width;
            };
            if (_SafeStr_3320)
            {
                if (_SafeStr_3318.roomObjectSpriteId >= 0)
                {
                    _visualization.getSprite(_SafeStr_3318.roomObjectSpriteId).visible = false;
                };
            };
        }

        public function updateAnimation():void
        {
            var _local_9:int;
            var _local_10:int;
            var _local_1:Rectangle;
            var _local_11:IGraphicAsset;
            var _local_3:BitmapData;
            var _local_8:Point;
            if (((!(_SafeStr_3318)) || (!(_SafeStr_3319))))
            {
                return;
            };
            var _local_5:Number = 10;
            var _local_4:Number = 0;
            var _local_2:int;
            if (((!(_SafeStr_3320)) && (_SafeStr_3318.hasIgnited)))
            {
                _SafeStr_3320 = true;
            };
            _local_2 = (_offsetY * _SafeStr_3321);
            _SafeStr_3318.update();
            if (_SafeStr_3320)
            {
                if (_SafeStr_3318.roomObjectSpriteId >= 0)
                {
                    _visualization.getSprite(_SafeStr_3318.roomObjectSpriteId).visible = false;
                };
                if (!_SafeStr_1267)
                {
                    updateCanvas();
                };
                _SafeStr_1267.lock();
                if (_SafeStr_3315.alphaMultiplier == 1)
                {
                    _SafeStr_1267.fillRect(_SafeStr_1267.rect, _bgColor);
                }
                else
                {
                    _SafeStr_1267.draw(_SafeStr_3322, _SafeStr_3324, _SafeStr_3315, "normal", null, false);
                };
                for each (var _local_7:FurnitureParticleSystemParticle in _SafeStr_3318.particles)
                {
                    _local_4 = _local_7.y;
                    _local_9 = int((_SafeStr_2291 + ((((_local_7.x - _local_7.z) * _local_5) / 10) * _SafeStr_3321)));
                    _local_10 = int(((_SafeStr_2292 - _local_2) + ((((_local_4 + ((_local_7.x + _local_7.z) / 2)) * _local_5) / 10) * _SafeStr_3321)));
                    _local_11 = _local_7.getAsset();
                    if (_local_11)
                    {
                        _local_3 = (_local_11.asset.content as BitmapData);
                        if (((_local_7.fade) && (_local_7.alphaMultiplier < 1)))
                        {
                            _SafeStr_3325.identity();
                            _SafeStr_3325.translate((_local_9 + _local_11.offsetX), (_local_10 + _local_11.offsetY));
                            _SafeStr_3323.alphaMultiplier = _local_7.alphaMultiplier;
                            _SafeStr_1267.draw(_local_3, _SafeStr_3325, _SafeStr_3323, "normal", null, false);
                        }
                        else
                        {
                            _local_8 = new Point((_local_9 + _local_11.offsetX), (_local_10 + _local_11.offsetY));
                            _SafeStr_1267.copyPixels(_local_3, _local_3.rect, _local_8, null, null, true);
                        };
                    }
                    else
                    {
                        _local_1 = new Rectangle((_local_9 - 1), (_local_10 - 1), 2, 2);
                        _SafeStr_1267.fillRect(_local_1, 0xFFFFFFFF);
                    };
                };
                _SafeStr_1267.unlock();
            };
        }

        public function parseData(_arg_1:XML):void
        {
            var _local_9:int;
            var _local_21:String;
            var _local_4:int;
            var _local_24:FurnitureParticleSystemEmitter;
            var _local_19:int;
            var _local_14:int;
            var _local_25:int;
            var _local_18:int;
            var _local_22:Number;
            var _local_11:Number;
            var _local_20:Number;
            var _local_3:Number;
            var _local_15:String;
            var _local_12:Number;
            var _local_10:int;
            var _local_13:Boolean;
            var _local_5:Boolean;
            var _local_16:Array;
            var _local_23:IGraphicAsset;
            _SafeStr_3316 = parseInt(_arg_1.@size);
            _SafeStr_3317 = ((_arg_1.hasOwnProperty("@canvas_id")) ? parseInt(_arg_1.@canvas_id) : -1);
            _offsetY = ((_arg_1.hasOwnProperty("@offset_y")) ? parseInt(_arg_1.@offset_y) : 10);
            _SafeStr_3321 = (_SafeStr_3316 / 64);
            _SafeStr_1230 = ((_arg_1.hasOwnProperty("@blend")) ? Number(_arg_1.@blend) : 1);
            _SafeStr_1230 = Math.min(_SafeStr_1230, 1);
            _SafeStr_3315.alphaMultiplier = _SafeStr_1230;
            var _local_8:String = ((_arg_1.hasOwnProperty("@bgcolor")) ? String(_arg_1.@bgcolor) : "0");
            _bgColor = ((_arg_1.hasOwnProperty("@bgcolor")) ? parseInt(_local_8, 16) : 0xFF000000);
            for each (var _local_6:XML in _arg_1.emitter)
            {
                _local_9 = parseInt(_local_6.@id);
                _local_21 = _local_6.@name;
                _local_4 = parseInt(_local_6.@sprite_id);
                _local_24 = new FurnitureParticleSystemEmitter(_local_21, _local_4);
                _emitters[_local_9] = _local_24;
                _local_19 = parseInt(_local_6.@max_num_particles);
                _local_14 = parseInt(_local_6.@particles_per_frame);
                _local_25 = ((_local_6.hasOwnProperty("@burst_pulse")) ? parseInt(_local_6.@burst_pulse) : 1);
                _local_18 = parseInt(_local_6.@fuse_time);
                _local_22 = Number(_local_6.simulation.@force);
                _local_11 = Number(_local_6.simulation.@direction);
                _local_20 = Number(_local_6.simulation.@gravity);
                _local_3 = Number(_local_6.simulation.@airfriction);
                _local_15 = _local_6.simulation.@shape;
                _local_12 = Number(_local_6.simulation.@energy);
                for each (var _local_17:XML in _local_6.particles.particle)
                {
                    _local_10 = parseInt(_local_17.@lifetime);
                    _local_13 = ((_local_17.@is_emitter == "false") ? false : true);
                    _local_5 = (((_local_17.hasOwnProperty("@fade")) && (_local_17.@fade == "true")) ? true : false);
                    _local_16 = [];
                    for each (var _local_2:XML in _local_17.frame)
                    {
                        _local_23 = _visualization.assetCollection.getAsset(_local_2.@name);
                        _local_16.push(_local_23);
                    };
                    _local_24.configureParticle(_local_10, _local_13, _local_16, _local_5);
                };
                _local_24.setup(_local_19, _local_14, _local_22, new Vector3D(0, _local_11, 0), _local_20, _local_3, _local_15, _local_12, _local_18, _local_25);
            };
        }

        public function copyStateFrom(_arg_1:FurnitureParticleSystem):void
        {
            var _local_2:int;
            if (((_arg_1._emitters) && (_arg_1._SafeStr_3318)))
            {
                _local_2 = _arg_1._emitters.getKey(_arg_1._emitters.getValues().indexOf(_arg_1._SafeStr_3318));
            };
            setAnimation(_local_2);
            if (_SafeStr_3318)
            {
                _SafeStr_3318.copyStateFrom(_arg_1._SafeStr_3318, (_arg_1._SafeStr_3316 / _SafeStr_3316));
            };
            _SafeStr_1267 = null;
        }


    }
}

