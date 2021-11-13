package com.sulake.habbo.freeflowchat.viewer.visualization
{
    import flash.display.Sprite;
    import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
    import com.sulake.habbo.freeflowchat.data.ChatItem;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.text.TextField;
    import com.sulake.habbo.freeflowchat.viewer.visualization.style.IChatStyleInternal;
    import com.sulake.habbo.freeflowchat.viewer.enum.ChatBubbleWidth;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.events.TextEvent;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.events.MouseEvent;

    public class PooledChatBubble extends Sprite 
    {

        public static const MAX_WIDTH_DEFAULT:uint = 300;

        private const DESKTOP_MARGIN_LEFT:int = 85;
        private const DESKTOP_MARGIN_RIGHT:int = 190;
        private const LINEAR_INTERPOLATION_MS:uint = 150;
        private const MAX_HEIGHT:uint = 108;
        private const _SafeStr_2203:int = 28;
        private const POINTER_MARGIN_RIGHT:int = 15;
        private const POINTER_REPOSITION_INTERVAL_MS:int = 2000;

        private var _SafeStr_659:HabboFreeFlowChat;
        private var _SafeStr_2204:ChatItem;
        private var _background:Sprite;
        private var _SafeStr_2200:Bitmap;
        private var _SafeStr_2201:Bitmap;
        private var _SafeStr_2215:BitmapData;
        private var _SafeStr_2199:TextField;
        private var _style:IChatStyleInternal;
        private var _SafeStr_2205:uint = 0;
        private var _SafeStr_2206:uint;
        private var _SafeStr_2207:int;
        private var _SafeStr_2208:int;
        private var _SafeStr_2209:int;
        private var _SafeStr_2210:int;
        private var _SafeStr_2211:Number;
        private var _SafeStr_2212:Number;
        private var _readyToRecycle:Boolean = false;
        private var _SafeStr_2213:int = 0;
        private var _proxyX:int;
        private var _SafeStr_2214:Boolean = false;
        private var _hasHitDesktopMargin:Boolean = false;
        private var _SafeStr_664:Sprite;
        private var _SafeStr_2216:uint = 0;
        private var _minHeight:int = -1;

        public function PooledChatBubble(_arg_1:HabboFreeFlowChat)
        {
            _SafeStr_659 = _arg_1;
            _SafeStr_2200 = new Bitmap();
            _SafeStr_2201 = new Bitmap();
            _SafeStr_2199 = new TextField();
            _SafeStr_664 = new Sprite();
            this.addEventListener("addedToStage", onAddedToStage);
            this.addEventListener("removedFromStage", onRemovedFromStage);
        }

        public function set chatItem(_arg_1:ChatItem):void
        {
            _SafeStr_2204 = _arg_1;
        }

        public function set face(_arg_1:BitmapData):void
        {
            _SafeStr_2215 = _arg_1;
        }

        public function set style(_arg_1:IChatStyleInternal):void
        {
            _style = _arg_1;
        }

        public function recreate(_arg_1:String, _arg_2:uint, _arg_3:Boolean=false, _arg_4:int=-1):void
        {
            var _local_10:int;
            var _local_14:int;
            var _local_16:Array;
            var _local_15:String;
            var _local_19:String;
            var _local_20:String;
            var _local_8:int;
            var _local_12:BitmapData;
            _background = _style.getNewBackgroundSprite(_arg_2);
            _SafeStr_2200.bitmapData = _style.pointer;
            _SafeStr_2214 = _arg_3;
            var _local_11:int = ((_SafeStr_659.roomChatSettings) ? ChatBubbleWidth.accordingToRoomChatSetting(_SafeStr_659.roomChatSettings.bubbleWidth) : 300);
            var _local_9:int = ((_local_11 - _style.textFieldMargins.x) - _style.textFieldMargins.width);
            _SafeStr_2199.width = _local_9;
            _SafeStr_2199.multiline = true;
            _SafeStr_2199.wordWrap = true;
            _SafeStr_2199.selectable = false;
            _SafeStr_2199.thickness = -15;
            _SafeStr_2199.sharpness = 80;
            _SafeStr_2199.antiAliasType = "advanced";
            _SafeStr_2199.embedFonts = true;
            _SafeStr_2199.gridFitType = "pixel";
            _SafeStr_2199.cacheAsBitmap = (!(_style.allowHTML));
            _SafeStr_2199.styleSheet = null;
            _SafeStr_2199.defaultTextFormat = _style.textFormat;
            _SafeStr_2199.styleSheet = _style.styleSheet;
            _SafeStr_2199.addEventListener("link", onTextLinkEvent);
            var _local_7:Boolean = (_SafeStr_2204.chatType == 0);
            var _local_6:Boolean = (_SafeStr_2204.chatType == 2);
            var _local_13:Boolean = (((!(_local_7)) && (!(_local_6))) && (!(_style.isAnonymous)));
            if (_local_13)
            {
                _SafeStr_2199.alpha = 0.6;
            }
            else
            {
                _SafeStr_2199.alpha = 1;
            };
            var _local_18:String = (((_local_13) ? "<i>" : "") + ((_style.isAnonymous) ? "" : (("<b>" + _arg_1) + ": </b>")));
            _local_18 = (((_local_18 + ((_local_6) ? "<b>" : "")) + _SafeStr_2204.text) + ((_local_6) ? "</b>" : ""));
            _local_18 = (_local_18 + ((_local_13) ? "</i>" : ""));
            if (((_SafeStr_2204.links == null) || (_SafeStr_2204.links[0] == null)))
            {
                _SafeStr_2199.htmlText = _local_18;
            }
            else
            {
                _local_14 = -1;
                _local_16 = [];
                _local_10 = 0;
                while (_local_10 < _SafeStr_2204.links.length)
                {
                    _local_15 = _SafeStr_2204.links[_local_10][0][1];
                    _local_19 = (((('<a href="' + _local_15) + '">') + _local_15) + "</a>");
                    _local_20 = (("{" + _local_10) + "}");
                    _local_8 = _SafeStr_2204.text.indexOf(_local_20);
                    _local_14 = (_local_8 + _local_19.length);
                    _local_16.push([_local_8, _local_14]);
                    _local_18 = _local_18.replace(_local_20, _local_19);
                    _local_10++;
                };
                _SafeStr_2199.htmlText = _local_18;
            };
            _minHeight = _arg_4;
            var _local_17:int = Math.min(_local_11, ((_SafeStr_2199.textWidth + _style.textFieldMargins.x) + _style.textFieldMargins.width));
            var _local_5:int = ((_SafeStr_2199.textHeight + _style.textFieldMargins.y) + _style.textFieldMargins.height);
            if (!_style.isSystemStyle)
            {
                _local_5 = Math.min(108, _local_5);
            };
            if (_arg_4 != -1)
            {
                _local_5 = Math.max(_arg_4, _local_5);
            };
            _local_17 = Math.max(_local_17, _background.width);
            _local_5 = Math.max(_local_5, _background.height);
            _background.width = _local_17;
            _background.height = _local_5;
            _background.x = 0;
            _background.y = 0;
            _background.cacheAsBitmap = true;
            addChild(_background);
            if (!_style.isAnonymous)
            {
                _SafeStr_2200.x = Math.max(28, Math.min(15, userRelativePosX));
                _SafeStr_2200.y = (_local_5 - _style.pointerOffsetToBubbleBottom);
                addChild(_SafeStr_2200);
            };
            if (((!(_SafeStr_2215 == null)) && (!(_style.faceOffset == null))))
            {
                if (_SafeStr_2215.height > _local_5)
                {
                    _local_12 = new BitmapData(_SafeStr_2215.width, _local_5);
                    _local_12.copyPixels(_SafeStr_2215, new Rectangle(0, (_SafeStr_2215.height - _local_5), _SafeStr_2215.width, _local_5), new Point(0, 0));
                }
                else
                {
                    _local_12 = _SafeStr_2215;
                };
                _SafeStr_2201.bitmapData = _local_12;
                _SafeStr_2201.x = (_style.faceOffset.x - (_local_12.width / 2));
                _SafeStr_2201.y = Math.max(1, (_style.faceOffset.y - (_local_12.height / 2)));
                addChild(_SafeStr_2201);
            };
            _SafeStr_2199.width = Math.min(_local_9, (_SafeStr_2199.textWidth + _style.textFieldMargins.width));
            _SafeStr_2199.height = (_SafeStr_2199.textHeight + _style.textFieldMargins.height);
            _SafeStr_2199.x = _style.textFieldMargins.x;
            _SafeStr_2199.y = _style.textFieldMargins.y;
            addChild(_SafeStr_2199);
            if (((!(_style.isSystemStyle)) && (_SafeStr_2199.textHeight > 108)))
            {
                _SafeStr_664.graphics.clear();
                _SafeStr_664.graphics.beginFill(0xFFFFFF);
                _SafeStr_664.graphics.drawRect(0, 0, (_SafeStr_2199.textWidth + 5), (108 - _style.textFieldMargins.height));
                _SafeStr_664.graphics.endFill();
                _SafeStr_2199.mask = _SafeStr_664;
                addChild(_SafeStr_664);
                _SafeStr_664.x = _SafeStr_2199.x;
                _SafeStr_664.y = _SafeStr_2199.y;
            }
            else
            {
                _SafeStr_664.graphics.clear();
                _SafeStr_2199.mask = null;
            };
            this.cacheAsBitmap = (!(_style.allowHTML));
            _readyToRecycle = false;
            _SafeStr_2205 = 0;
            _SafeStr_2216 = 0;
            visible = false;
        }

        public function unregister():void
        {
            this.cacheAsBitmap = false;
            this.removeEventListener("click", onMouseClick);
            if (_SafeStr_664.parent == this)
            {
                safelyRemoveChild(_SafeStr_664);
            };
            safelyRemoveChild(_SafeStr_2199);
            if (((!(_style.faceOffset == null)) && (_SafeStr_2201.parent == this)))
            {
                safelyRemoveChild(_SafeStr_2201);
                _SafeStr_2201.bitmapData = null;
            };
            if (((_SafeStr_2200) && (_SafeStr_2200.parent)))
            {
                safelyRemoveChild(_SafeStr_2200);
            };
            safelyRemoveChild(_background);
            if (_SafeStr_2199)
            {
                _SafeStr_2199.removeEventListener("link", onTextLinkEvent);
            };
        }

        private function onTextLinkEvent(_arg_1:TextEvent):void
        {
            var _local_7:String;
            var _local_4:String;
            var _local_3:TextField;
            var _local_2:Point;
            var _local_5:Rectangle;
            var _local_6:String;
            if (((_arg_1.text) && (_arg_1.text.length > 0)))
            {
                _local_7 = _arg_1.text;
                _local_4 = "highlight/";
                if (_local_7.indexOf(_local_4) > -1)
                {
                    _local_3 = (_arg_1.target as TextField);
                    _local_2 = new Point(_local_3.mouseX, _local_3.mouseY);
                    _local_2 = _local_3.localToGlobal(_local_2);
                    _local_5 = new Rectangle(_local_2.x, _local_2.y);
                    _local_6 = _local_7.substr((_local_7.indexOf(_local_4) + _local_4.length), _local_7.length);
                    _SafeStr_659.windowManager.hideHint();
                    _SafeStr_659.windowManager.showHint(_local_6.toLocaleUpperCase(), _local_5);
                }
                else
                {
                    _SafeStr_659.context.createLinkEvent(_arg_1.text);
                };
            };
        }

        private function safelyRemoveChild(_arg_1:DisplayObject):void
        {
            try
            {
                removeChild(_arg_1);
            }
            catch(error:ArgumentError)
            {
            };
        }

        public function get displayedHeight():Number
        {
            return ((_style.isSystemStyle) ? height : Math.min(108, height));
        }

        private function onAddedToStage(_arg_1:Event):void
        {
            this.addEventListener("click", onMouseClick);
        }

        private function onRemovedFromStage(_arg_1:Event):void
        {
            this.removeEventListener("click", onMouseClick);
        }

        public function moveTo(_arg_1:int, _arg_2:int):void
        {
            if (((!(_SafeStr_2207 == _arg_1)) || (!(_SafeStr_2208 == _arg_2))))
            {
                _SafeStr_2206 = _SafeStr_2205;
                _SafeStr_2209 = proxyX;
                _SafeStr_2210 = y;
                _SafeStr_2207 = _arg_1;
                _SafeStr_2208 = _arg_2;
                _SafeStr_2211 = ((_arg_1 - proxyX) / 150);
                _SafeStr_2212 = ((_arg_2 - y) / 150);
            };
        }

        public function warpTo(_arg_1:int, _arg_2:int):void
        {
            _SafeStr_2207 = _arg_1;
            _SafeStr_2208 = _arg_2;
            proxyX = _arg_1;
            y = _arg_2;
        }

        public function update(_arg_1:uint):void
        {
            var _local_2:uint;
            _SafeStr_2205 = (_SafeStr_2205 + _arg_1);
            if (((!(proxyX == _SafeStr_2207)) || (!(y == _SafeStr_2208))))
            {
                _local_2 = (_SafeStr_2205 - _SafeStr_2206);
                if (((_local_2 < 150) && (_local_2 > 0)))
                {
                    proxyX = (_SafeStr_2209 + (_local_2 * _SafeStr_2211));
                    y = (_SafeStr_2210 + (_local_2 * _SafeStr_2212));
                }
                else
                {
                    proxyX = _SafeStr_2207;
                    y = _SafeStr_2208;
                };
            };
            if (_SafeStr_2205 > (_SafeStr_2216 + 2000))
            {
                repositionPointer();
                _SafeStr_2216 = _SafeStr_2205;
            };
            if (((_SafeStr_2205 > 150) && (!(visible))))
            {
                visible = true;
            };
        }

        public function get proxyX():int
        {
            return (_proxyX);
        }

        public function set proxyX(_arg_1:int):void
        {
            var _local_2:int;
            var _local_3:int;
            _proxyX = _arg_1;
            if (((_SafeStr_2214) && (stage)))
            {
                _local_2 = (_proxyX + _SafeStr_2213);
                _hasHitDesktopMargin = false;
                _local_3 = ((stage.stageWidth - 190) - width);
                if (_local_2 > _local_3)
                {
                    _local_2 = _local_3;
                    _hasHitDesktopMargin = true;
                };
                if (_local_2 < 85)
                {
                    _local_2 = 85;
                    _hasHitDesktopMargin = true;
                };
                x = _local_2;
            }
            else
            {
                x = (_proxyX + _SafeStr_2213);
            };
        }

        public function repositionPointer():void
        {
            if (((_SafeStr_2200) && (_SafeStr_2200.parent)))
            {
                _SafeStr_2200.x = Math.max(28, Math.min((_background.width - 15), userRelativePosX));
                _SafeStr_2200.y = (_background.height - _style.pointerOffsetToBubbleBottom);
            };
        }

        public function get readyToRecycle():Boolean
        {
            return (_readyToRecycle);
        }

        public function set readyToRecycle(_arg_1:Boolean):void
        {
            _readyToRecycle = _arg_1;
            if (_arg_1)
            {
                this.removeEventListener("click", onMouseClick);
            };
        }

        public function get timeStamp():uint
        {
            return (_SafeStr_2204.timeStamp);
        }

        public function set component(_arg_1:HabboFreeFlowChat):void
        {
            _SafeStr_659 = _arg_1;
        }

        private function get userRelativePosX():int
        {
            return (userScreenPos.x - this.x);
        }

        public function get userScreenPos():Point
        {
            if (_SafeStr_2204.forcedScreenLocation)
            {
                return (new Point(((_SafeStr_659.displayObject.stage.stageWidth / 2) + _SafeStr_2204.forcedScreenLocation), 500));
            };
            return (_SafeStr_659.getScreenPointFromRoomLocation(_SafeStr_2204.roomId, _SafeStr_2204.userLocation));
        }

        public function get roomId():int
        {
            return (_SafeStr_2204.roomId);
        }

        public function set roomPanOffsetX(_arg_1:int):void
        {
            if (_SafeStr_2213 != _arg_1)
            {
                _SafeStr_2213 = _arg_1;
                warpTo(_SafeStr_2207, _SafeStr_2208);
            };
        }

        private function onMouseClick(_arg_1:MouseEvent):void
        {
            if (((_style) && (_style.isAnonymous)))
            {
                return;
            };
            if (!_SafeStr_659.clickHasToPropagate(_arg_1))
            {
                _SafeStr_659.selectAvatarWithChatItem(_SafeStr_2204);
                _arg_1.stopImmediatePropagation();
            };
        }

        public function get overlap():Rectangle
        {
            return (_style.overlap);
        }

        public function get hasHitDesktopMargin():Boolean
        {
            return (_hasHitDesktopMargin);
        }

        public function get minHeight():int
        {
            return (_minHeight);
        }


    }
}

