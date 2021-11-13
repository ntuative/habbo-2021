package com.sulake.habbo.room.object.visualization.furniture
{
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import com.sulake.room.utils._SafeStr_217;

    public class ShoreMaskCreatorUtility 
    {

        public static const _SafeStr_3403:int = 0;
        public static const STRAIGHT_CUT:int = 1;
        public static const INNER_CUT:int = 2;
        private static const CUT_TYPE_COUNT:int = 3;
        private static const MASK_COLOR_TRANSPARENT:uint = 0;
        private static const MASK_COLOR_SOLID:uint = 0xFFFFFFFF;


        public static function createEmptyMask(_arg_1:int, _arg_2:int):BitmapData
        {
            return (new BitmapData(_arg_1, _arg_2, true, 0));
        }

        public static function getInstanceMaskName(_arg_1:int, _arg_2:int):String
        {
            return ((("instance_mask_" + _arg_1) + "_") + _arg_2);
        }

        public static function getBorderType(_arg_1:int, _arg_2:int):int
        {
            return (_arg_1 + (_arg_2 * 3));
        }

        public static function getInstanceMask(_arg_1:int, _arg_2:int, _arg_3:IGraphicAssetCollection, _arg_4:IGraphicAsset):IGraphicAsset
        {
            var _local_8:BitmapDataAsset;
            var _local_6:BitmapData;
            var _local_7:String = getInstanceMaskName(_arg_1, _arg_2);
            var _local_5:IGraphicAsset = _arg_3.getAsset(_local_7);
            if (_local_5 == null)
            {
                if (_arg_4 != null)
                {
                    _local_8 = (_arg_4.asset as BitmapDataAsset);
                    if (_local_8 != null)
                    {
                        _local_6 = (_local_8.content as BitmapData);
                        if (_local_6 != null)
                        {
                            _arg_3.addAsset(_local_7, new BitmapData(_local_6.width, _local_6.height, true, 0), false, _arg_4.offsetX, _arg_4.offsetY);
                            _local_5 = _arg_3.getAsset(_local_7);
                        };
                    };
                };
            };
            return (_local_5);
        }

        public static function disposeInstanceMask(_arg_1:int, _arg_2:int, _arg_3:IGraphicAssetCollection):void
        {
            var _local_4:String = getInstanceMaskName(_arg_1, _arg_2);
            _arg_3.disposeAsset(_local_4);
        }

        public static function createShoreMask2x2(_arg_1:BitmapData, _arg_2:int, _arg_3:Array, _arg_4:Array, _arg_5:IGraphicAssetCollection):BitmapData
        {
            var _local_6:int;
            var _local_7:String;
            var _local_9:IGraphicAsset;
            var _local_8:BitmapData;
            _arg_1.fillRect(_arg_1.rect, 0);
            _local_6 = 0;
            while (_local_6 < _arg_3.length)
            {
                if (_arg_3[_local_6] == true)
                {
                    _local_7 = ((((("mask_" + _arg_2) + "_") + _local_6) + "_") + _arg_4[_local_6]);
                    _local_9 = _arg_5.getAsset(_local_7);
                    if (((!(_local_9 == null)) && (!(_local_9.asset == null))))
                    {
                        _local_8 = (_local_9.asset.content as BitmapData);
                        if (_local_8 != null)
                        {
                            _arg_1.copyPixels(_local_8, _local_8.rect, new Point(0, 0), _local_8, new Point(0, 0), true);
                        };
                    };
                };
                _local_6++;
            };
            return (_arg_1);
        }

        public static function initializeShoreMasks(_arg_1:int, _arg_2:IGraphicAssetCollection, _arg_3:IGraphicAsset):Boolean
        {
            var _local_4:String;
            var _local_7:BitmapDataAsset;
            var _local_5:BitmapData;
            var _local_9:Array;
            var _local_8:Array;
            var _local_10:BitmapData;
            var _local_6:int;
            if (_arg_2 != null)
            {
                _local_4 = ("masks_done_" + _arg_1);
                if (_arg_2.getAsset(_local_4) == null)
                {
                    if (_arg_3 != null)
                    {
                        _local_7 = (_arg_3.asset as BitmapDataAsset);
                        if (_local_7 != null)
                        {
                            _local_5 = (_local_7.content as BitmapData);
                            _local_9 = [0, 1, 2, 0, 1, 2];
                            _local_8 = [1, 1, 1, 2, 2, 2];
                            _local_10 = null;
                            _local_6 = 0;
                            if (_local_5 != null)
                            {
                                _local_6 = 0;
                                while (((_local_6 < _local_9.length) && (_local_6 < _local_8.length)))
                                {
                                    _local_10 = createMaskLeft(_local_5.width, _local_5.height);
                                    cutLeftMask(_local_10, _arg_1, _local_9[_local_6], _local_8[_local_6]);
                                    storeLeftMask(_arg_2, _local_10, _arg_1, _local_9[_local_6], _local_8[_local_6]);
                                    _local_10 = createMaskRight(_local_5.width, _local_5.height);
                                    cutRightMask(_local_10, _arg_1, _local_8[_local_6], _local_9[_local_6]);
                                    storeRightMask(_arg_2, _local_10, _arg_1, _local_8[_local_6], _local_9[_local_6]);
                                    _local_6++;
                                };
                            };
                        };
                        _arg_2.addAsset(_local_4, new BitmapData(1, 1), false);
                        return (true);
                    };
                    return (false);
                };
                return (true);
            };
            return (false);
        }

        private static function createMaskLeft(_arg_1:int, _arg_2:int):BitmapData
        {
            var _local_3:BitmapData = new BitmapData(_arg_1, _arg_2, true, 0);
            fillTopLeftCorner(_local_3, (_local_3.width / 2), ((_local_3.height / 2) - 1), 1, 0xFFFFFFFF);
            return (_local_3);
        }

        private static function cutLeftMask(_arg_1:BitmapData, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            if (_arg_3 == 1)
            {
                cutLeftMaskOuterCorner(_arg_1, _arg_2, false);
            }
            else
            {
                if (_arg_3 == 2)
                {
                    cutLeftMaskOuterCorner(_arg_1, _arg_2, true);
                };
            };
            if (_arg_4 == 2)
            {
                cutLeftMaskInnerCorner(_arg_1, _arg_2);
            };
        }

        private static function cutLeftMaskOuterCorner(_arg_1:BitmapData, _arg_2:int, _arg_3:Boolean):void
        {
            var _local_4:int = int(((_arg_1.height / 2) - (_arg_2 / 2)));
            var _local_5:int = int((_arg_1.width / 2));
            if (_arg_3)
            {
                _arg_1.fillRect(new Rectangle(_local_5, 0, _arg_1.width, _local_4), 0);
            }
            else
            {
                fillTopLeftCorner(_arg_1, _local_5, (_local_4 - 1), 1, 0);
            };
        }

        private static function cutLeftMaskInnerCorner(_arg_1:BitmapData, _arg_2:int):void
        {
            var _local_3:int = int(((_arg_1.width / 2) + (_arg_2 / 2)));
            _arg_1.fillRect(new Rectangle(_local_3, 0, _arg_1.width, (_arg_1.height / 2)), 0);
        }

        private static function createMaskRight(_arg_1:int, _arg_2:int):BitmapData
        {
            var _local_3:BitmapData = new BitmapData(_arg_1, _arg_2, true, 0);
            fillBottomRightCorner(_local_3, ((_local_3.width / 2) + 1), ((_local_3.height / 2) - 1), 0xFFFFFFFF);
            return (_local_3);
        }

        private static function cutRightMask(_arg_1:BitmapData, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            if (_arg_4 == 1)
            {
                cutRightMaskOuterCorner(_arg_1, _arg_2, false);
            }
            else
            {
                if (_arg_4 == 2)
                {
                    cutRightMaskOuterCorner(_arg_1, _arg_2, true);
                };
            };
            if (_arg_3 == 2)
            {
                cutRightMaskInnerCorner(_arg_1, _arg_2);
            };
        }

        private static function cutRightMaskInnerCorner(_arg_1:BitmapData, _arg_2:int):void
        {
            var _local_3:int = int(((_arg_1.width / 2) + (_arg_2 / 2)));
            _arg_1.fillRect(new Rectangle(_local_3, 0, _arg_1.width, ((_arg_1.height / 2) - (_arg_2 / 4))), 0);
        }

        private static function cutRightMaskOuterCorner(_arg_1:BitmapData, _arg_2:int, _arg_3:Boolean):void
        {
            var _local_4:int = int((_arg_1.height / 2));
            var _local_5:int = int(((_arg_1.width / 2) + _arg_2));
            if (_arg_3)
            {
                _arg_1.fillRect(new Rectangle(_local_5, 0, _arg_1.width, _local_4), 0);
            }
            else
            {
                fillBottomRightCorner(_arg_1, (_local_5 + 1), (_local_4 - 1), 0);
            };
        }

        private static function storeLeftMask(_arg_1:IGraphicAssetCollection, _arg_2:BitmapData, _arg_3:int, _arg_4:int, _arg_5:int):void
        {
            var _local_6:String;
            if (_arg_1 != null)
            {
                _local_6 = "";
                _local_6 = ((("mask_" + _arg_3) + "_0_") + getBorderType(_arg_4, _arg_5));
                _arg_1.addAsset(_local_6, _arg_2, false);
                _local_6 = ((("mask_" + _arg_3) + "_3_") + getBorderType(_arg_5, _arg_4));
                _arg_1.addAsset(_local_6, _SafeStr_217.getFlipVBitmapData(_arg_2), false);
                _local_6 = ((("mask_" + _arg_3) + "_4_") + getBorderType(_arg_4, _arg_5));
                _arg_1.addAsset(_local_6, _SafeStr_217.getFlipHVBitmapData(_arg_2), false);
                _local_6 = ((("mask_" + _arg_3) + "_7_") + getBorderType(_arg_5, _arg_4));
                _arg_1.addAsset(_local_6, _SafeStr_217.getFlipHBitmapData(_arg_2), false);
            };
        }

        private static function storeRightMask(_arg_1:IGraphicAssetCollection, _arg_2:BitmapData, _arg_3:int, _arg_4:int, _arg_5:int):void
        {
            var _local_6:String;
            if (_arg_1 != null)
            {
                _local_6 = "";
                _local_6 = ((("mask_" + _arg_3) + "_1_") + getBorderType(_arg_4, _arg_5));
                _arg_1.addAsset(_local_6, _arg_2, false);
                _local_6 = ((("mask_" + _arg_3) + "_2_") + getBorderType(_arg_5, _arg_4));
                _arg_1.addAsset(_local_6, _SafeStr_217.getFlipVBitmapData(_arg_2), false);
                _local_6 = ((("mask_" + _arg_3) + "_5_") + getBorderType(_arg_4, _arg_5));
                _arg_1.addAsset(_local_6, _SafeStr_217.getFlipHVBitmapData(_arg_2), false);
                _local_6 = ((("mask_" + _arg_3) + "_6_") + getBorderType(_arg_5, _arg_4));
                _arg_1.addAsset(_local_6, _SafeStr_217.getFlipHBitmapData(_arg_2), false);
            };
        }

        private static function fillTopLeftCorner(_arg_1:BitmapData, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:uint):void
        {
            var _local_9:int;
            var _local_6:int = _arg_2;
            var _local_7:int = _arg_3;
            var _local_8:int = _arg_4;
            while (_local_7 >= 0)
            {
                _local_9 = _local_7;
                while (_local_9 >= 0)
                {
                    _arg_1.setPixel32(_local_6, _local_9, _arg_5);
                    _local_9--;
                };
                if (++_local_8 >= 2)
                {
                    _local_7--;
                    _local_8 = 0;
                };
                _local_6++;
            };
        }

        private static function fillBottomRightCorner(_arg_1:BitmapData, _arg_2:int, _arg_3:int, _arg_4:uint):void
        {
            var _local_7:int;
            var _local_5:int = _arg_2;
            var _local_6:int = _arg_3;
            while (_local_5 < _arg_1.width)
            {
                _local_7 = _local_5;
                while (_local_7 < _arg_1.width)
                {
                    _arg_1.setPixel32(_local_7, _local_6, _arg_4);
                    _local_7++;
                };
                _local_6--;
                _local_5 = (_local_5 + 2);
            };
        }


    }
}

