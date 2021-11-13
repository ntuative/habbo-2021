package com.sulake.core.window.graphics.renderer
{
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.utils.Dictionary;
    import flash.geom.Matrix;
    import flash.geom.ColorTransform;
    import com.sulake.core.window.graphics.BitmapSkinParser;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;

    public class BitmapSkinRenderer extends SkinRenderer implements ISkinRenderer 
    {

        protected static const _SafeStr_1104:Rectangle = new Rectangle();
        protected static const _SafeStr_1105:Point = new Point();

        protected var _bitmapCache:Dictionary;
        protected var _SafeStr_1106:Matrix;
        protected var _SafeStr_1107:ColorTransform;

        public function BitmapSkinRenderer(_arg_1:String)
        {
            super(_arg_1);
            _bitmapCache = new Dictionary(false);
            _SafeStr_1106 = new Matrix();
            _SafeStr_1107 = new ColorTransform();
        }

        override public function parse(_arg_1:IAsset, _arg_2:XMLList, _arg_3:IAssetLibrary):void
        {
            BitmapSkinParser.parseSkinDescription((_arg_1.content as XML), _arg_2, this, name, _arg_3);
        }

        override public function dispose():void
        {
            var _local_2:String;
            var _local_1:BitmapData;
            if (!disposed)
            {
                super.dispose();
                _SafeStr_1106 = null;
                _SafeStr_1107 = null;
                for (_local_2 in _bitmapCache)
                {
                    _local_1 = (_bitmapCache[_local_2] as BitmapData);
                    _local_1.dispose();
                    delete _bitmapCache[_local_2];
                };
                _bitmapCache = null;
            };
        }

        override public function isStateDrawable(_arg_1:uint):Boolean
        {
            return (!(_SafeStr_1108[_arg_1] == null));
        }

        override public function draw(_arg_1:IWindow, _arg_2:BitmapData, _arg_3:Rectangle, _arg_4:uint, _arg_5:Boolean):void
        {
            var _local_13:uint;
            var _local_8:ISkinTemplateEntity;
            var _local_15:Boolean;
            var _local_9:Boolean;
            var _local_20:uint;
            var _local_22:SkinLayoutEntity;
            var _local_14:BitmapData;
            var _local_24:int;
            var _local_27:uint;
            var _local_26:int;
            var _local_17:BitmapData;
            var _local_23:ISkinLayout = _SafeStr_1109[_arg_4];
            var _local_6:ISkinTemplate = _SafeStr_1108[_arg_4];
            if (_local_23 == null)
            {
                _local_23 = _SafeStr_1109[0];
                _local_6 = _SafeStr_1108[0];
            };
            _local_13 = _local_23.numChildren;
            if (((!(_local_23 == null)) && (_local_13 > 0)))
            {
                var _local_10:int = (_arg_3.width - _local_23.width);
                var _local_28:int = (_arg_3.height - _local_23.height);
                var _local_12:Boolean = ((!(_arg_1.background)) && ((_arg_1.color & 0xFFFFFF) < 0xFFFFFF));
                if (_local_12)
                {
                    _SafeStr_1107.redMultiplier = (((_arg_1.color & 0xFF0000) >> 16) / 0xFF);
                    _SafeStr_1107.greenMultiplier = (((_arg_1.color & 0xFF00) >> 8) / 0xFF);
                    _SafeStr_1107.blueMultiplier = ((_arg_1.color & 0xFF) / 0xFF);
                    _SafeStr_1107.alphaMultiplier = 1;
                };
                _local_20 = 0;
                while (_local_20 < _local_13)
                {
                    _local_22 = (_local_23.getChildAt(_local_20) as SkinLayoutEntity);
                    _local_8 = (_local_6.getChildByName(_local_22.name) as ISkinTemplateEntity);
                    if (_local_8 != null)
                    {
                        _local_14 = getBitmapFromCache(_local_6, _local_22.name);
                        if (((_local_12) && (_local_22.colorize)))
                        {
                            _local_14 = _local_14.clone();
                            _local_14.colorTransform(_local_14.rect, _SafeStr_1107);
                        };
                        _local_15 = false;
                        _local_9 = false;
                        _SafeStr_1104.x = (_local_22.region.x + _arg_3.x);
                        _SafeStr_1104.y = (_local_22.region.y + _arg_3.y);
                        _SafeStr_1104.width = _local_22.region.width;
                        _SafeStr_1104.height = _local_22.region.height;
                        if (_local_22.scaleH == 1)
                        {
                            _SafeStr_1104.x = (_SafeStr_1104.x + _local_10);
                        }
                        else
                        {
                            if (_local_22.scaleH == 2)
                            {
                                _local_15 = true;
                                _SafeStr_1104.right = (_SafeStr_1104.right + _local_10);
                                if (_SafeStr_1104.width < 1) break;
                            }
                            else
                            {
                                if (_local_22.scaleH == 4)
                                {
                                    _local_15 = true;
                                    _SafeStr_1104.right = (_SafeStr_1104.right + _local_10);
                                    if (_SafeStr_1104.width < 1) break;
                                }
                                else
                                {
                                    if (_local_22.scaleH == 8)
                                    {
                                        _SafeStr_1104.x = ((_arg_3.width / 2) - (_SafeStr_1104.width / 2));
                                    };
                                };
                            };
                        };
                        if (_local_22.scaleV == 1)
                        {
                            _SafeStr_1104.y = (_SafeStr_1104.y + _local_28);
                        }
                        else
                        {
                            if (_local_22.scaleV == 2)
                            {
                                _local_9 = true;
                                _SafeStr_1104.bottom = (_SafeStr_1104.bottom + _local_28);
                                if (_SafeStr_1104.height < 1) break;
                            }
                            else
                            {
                                if (_local_22.scaleV == 4)
                                {
                                    _local_9 = true;
                                    _SafeStr_1104.bottom = (_SafeStr_1104.bottom + _local_28);
                                    if (_SafeStr_1104.height < 1) break;
                                }
                                else
                                {
                                    if (_local_22.scaleV == 8)
                                    {
                                        _SafeStr_1104.y = ((_arg_3.height / 2) - (_SafeStr_1104.height / 2));
                                    };
                                };
                            };
                        };
                        if (((!(_local_15)) && (!(_local_9))))
                        {
                            _arg_2.copyPixels(_local_14, _local_14.rect, _SafeStr_1104.topLeft, null, null, true);
                        }
                        else
                        {
                            if (((_local_22.scaleV == 4) || (_local_22.scaleH == 4)))
                            {
                                _local_24 = _local_14.width;
                                var _local_19:int = _local_14.height;
                                var _local_11:int = int((_SafeStr_1104.width / _local_24));
                                var _local_29:int = int((_SafeStr_1104.height / _local_19));
                                var _local_16:int = (_SafeStr_1104.width % _local_24);
                                var _local_7:int = (_SafeStr_1104.height % _local_19);
                                var _local_25:Point = new Point(_SafeStr_1104.x, _SafeStr_1104.y);
                                var _local_18:Rectangle = new Rectangle(0, 0, _local_16, _local_14.height);
                                var _local_21:Rectangle = new Rectangle(0, 0, _local_14.width, _local_7);
                                _local_27 = 0;
                                while (_local_27 < _local_29)
                                {
                                    _local_25.x = _SafeStr_1104.x;
                                    _local_26 = 0;
                                    while (_local_26 < _local_11)
                                    {
                                        _arg_2.copyPixels(_local_14, _local_14.rect, _local_25, null, null, true);
                                        _local_25.x = (_local_25.x + _local_24);
                                        _local_26++;
                                    };
                                    if (_local_16 > 0)
                                    {
                                        _arg_2.copyPixels(_local_14, _local_18, _local_25, null, null, true);
                                    };
                                    _local_25.y = (_local_25.y + _local_19);
                                    _local_27++;
                                };
                                if (_local_7 > 0)
                                {
                                    _local_25.x = _SafeStr_1104.x;
                                    _local_27 = 0;
                                    while (_local_27 < _local_11)
                                    {
                                        _arg_2.copyPixels(_local_14, _local_21, _local_25, null, null, true);
                                        _local_25.x = (_local_25.x + _local_24);
                                        _local_27++;
                                    };
                                };
                            }
                            else
                            {
                                if (((_local_14.width == 1) && (_local_14.height == 1)))
                                {
                                    _SafeStr_1106.a = _SafeStr_1104.width;
                                    _SafeStr_1106.d = _SafeStr_1104.height;
                                    _SafeStr_1106.tx = _SafeStr_1104.x;
                                    _SafeStr_1106.ty = _SafeStr_1104.y;
                                    _arg_2.draw(_local_14, _SafeStr_1106);
                                }
                                else
                                {
                                    _SafeStr_1106.a = (_SafeStr_1104.width / _local_14.width);
                                    _SafeStr_1106.d = (_SafeStr_1104.height / _local_14.height);
                                    _SafeStr_1106.tx = 0;
                                    _SafeStr_1106.ty = 0;
                                    _local_17 = new BitmapData(_SafeStr_1104.width, _SafeStr_1104.height, true, 0);
                                    _local_17.draw(_local_14, _SafeStr_1106);
                                    _arg_2.copyPixels(_local_17, _local_17.rect, _SafeStr_1104.topLeft, null, null, true);
                                    _local_17.dispose();
                                };
                            };
                        };
                        if (((_local_12) && (_local_22.colorize)))
                        {
                            _local_14.dispose();
                        };
                    };
                    _local_20++;
                };
            };
        }

        protected function drawStaticLayoutEntity(_arg_1:BitmapData, _arg_2:Rectangle, _arg_3:ISkinLayout, _arg_4:SkinLayoutEntity, _arg_5:ISkinTemplate, _arg_6:ISkinTemplateEntity):void
        {
            var _local_7:BitmapData;
            var _local_8:Rectangle = _arg_4.region.clone();
            _local_8.x = (_local_8.x + _arg_2.x);
            _local_8.y = (_local_8.y + _arg_2.y);
            switch (_arg_6.type)
            {
                case "bitmap":
                    _local_7 = getBitmapFromCache(_arg_5, _arg_4.name);
                    if (_arg_4.scaleH == 1)
                    {
                        _local_8.x = (_local_8.x + (_arg_2.width - _arg_3.width));
                    };
                    if (_arg_4.scaleV == 1)
                    {
                        _local_8.y = (_local_8.y + (_arg_2.height - _arg_3.height));
                    };
                    _arg_1.copyPixels(_local_7, _local_7.rect, _local_8.topLeft, null, null, true);
                    return;
                case "fill":
                    _arg_1.fillRect(_local_8, _arg_4.color);
                    return;
            };
        }

        protected function getBitmapFromCache(_arg_1:ISkinTemplate, _arg_2:String):BitmapData
        {
            var _local_5:String;
            var _local_6:ISkinTemplateEntity;
            var _local_4:BitmapData;
            _local_5 = ((_arg_2 + "@") + _arg_1.name);
            var _local_3:BitmapData = _bitmapCache[_local_5];
            if (_local_3 == null)
            {
                _local_6 = (_arg_1.getChildByName(_arg_2) as ISkinTemplateEntity);
                if (_local_6 == null)
                {
                    throw (new Error((("Template entity" + _arg_2) + "not found!")));
                };
                _local_4 = (_arg_1.asset.content as BitmapData);
                if (_local_4 == null)
                {
                    throw (new Error((("Asset " + _arg_1.asset) + " not found!")));
                };
                _local_3 = new TrackedBitmapData(this, _local_6.region.width, _local_6.region.height, true);
                _local_3.copyPixels(_local_4, _local_6.region, _SafeStr_1105);
                _bitmapCache[_local_5] = _local_3;
            };
            return (_local_3);
        }

        private function drawBorders(_arg_1:BitmapData, _arg_2:Rectangle, _arg_3:uint):void
        {
            var _local_4:int;
            var _local_5:int = (_arg_2.bottom - 1);
            _local_4 = _arg_2.left;
            while (_local_4 < (_arg_2.right - 1))
            {
                _arg_1.setPixel32(_local_4, 0, _arg_3);
                _arg_1.setPixel32(_local_4, _local_5, _arg_3);
                _local_4++;
            };
            _local_5 = _arg_2.top;
            while (_local_5 < (_arg_2.bottom - 1))
            {
                _arg_1.setPixel32(0, _local_5, _arg_3);
                _arg_1.setPixel32(_local_4, _local_5, _arg_3);
                _local_5++;
            };
        }


    }
}

