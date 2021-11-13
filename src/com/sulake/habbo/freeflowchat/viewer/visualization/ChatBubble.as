package com.sulake.habbo.freeflowchat.viewer.visualization
{
    import flash.display.Sprite;
    import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
    import com.sulake.habbo.freeflowchat.data.ChatItem;
    import flash.display.Bitmap;
    import flash.text.TextField;
    import com.sulake.habbo.freeflowchat.viewer.visualization.style.IChatStyleInternal;
    import com.sulake.habbo.freeflowchat.viewer.enum.ChatBubbleWidth;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.events.TextEvent;
    import flash.events.Event;
    import flash.events.MouseEvent;

    public class ChatBubble extends Sprite 
    {

        public static const MAX_WIDTH_DEFAULT:uint = 300;
        public static const _SafeStr_2202:int = 15;

        private const DESKTOP_MARGIN_LEFT:int = 85;
        private const DESKTOP_MARGIN_RIGHT:int = 190;
        private const LINEAR_INTERPOLATION_MS:uint = 150;
        private const MAX_HEIGHT:uint = 108;
        private const _SafeStr_2203:int = 28;
        private const POINTER_MARGIN_RIGHT:int = 15;

        private var _SafeStr_659:HabboFreeFlowChat;
        private var _SafeStr_2204:ChatItem;
        private var _background:Sprite;
        private var _SafeStr_2200:Bitmap;
        private var _SafeStr_2201:Bitmap;
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

        public function ChatBubble(_arg_1:ChatItem, _arg_2:IChatStyleInternal, _arg_3:BitmapData, _arg_4:String, _arg_5:uint, _arg_6:HabboFreeFlowChat, _arg_7:int=-1, _arg_8:Boolean=false, _arg_9:int=-1)
        {
            super();
            var _local_21:int;
            var _local_24:int;
            var _local_25:Array = null;
            var _local_14:String = null;
            var _local_17:String = null;
            var _local_18:String = null;
            var _local_20:int;
            var _local_23:BitmapData = null;
            _SafeStr_659 = _arg_6;
            _SafeStr_2204 = _arg_1;
            _style = _arg_2;
            _background = _arg_2.getNewBackgroundSprite(_arg_5);
            _SafeStr_2200 = ((_arg_2.isAnonymous) ? null : new Bitmap(_arg_2.pointer));
            _SafeStr_2214 = _arg_8;
            var _local_22:int = 300;
            if (_arg_7 != -1)
            {
                _local_22 = ChatBubbleWidth.accordingToRoomChatSetting(_arg_7);
            }
            else
            {
                if (_arg_6.roomChatSettings)
                {
                    _local_22 = ChatBubbleWidth.accordingToRoomChatSetting(_arg_6.roomChatSettings.bubbleWidth);
                };
            };
            _local_22 = (_local_22 - 15);
            this.cacheAsBitmap = true;
            var _local_12:int = ((_local_22 - _arg_2.textFieldMargins.x) - _arg_2.textFieldMargins.width);
            _SafeStr_2199 = new TextField();
            _SafeStr_2199.width = _local_12;
            _SafeStr_2199.multiline = true;
            _SafeStr_2199.wordWrap = true;
            _SafeStr_2199.selectable = false;
            _SafeStr_2199.thickness = -15;
            _SafeStr_2199.sharpness = 80;
            _SafeStr_2199.antiAliasType = "advanced";
            _SafeStr_2199.embedFonts = true;
            _SafeStr_2199.gridFitType = "pixel";
            _SafeStr_2199.cacheAsBitmap = true;
            _SafeStr_2199.defaultTextFormat = _arg_2.textFormat;
            _SafeStr_2199.styleSheet = _style.styleSheet;
            _SafeStr_2199.addEventListener("link", onTextLinkEvent);
            var _local_11:Boolean = (_arg_1.chatType == 0);
            var _local_19:Boolean = (_arg_1.chatType == 2);
            var _local_13:Boolean = (((!(_local_11)) && (!(_local_19))) && (!(_style.isAnonymous)));
            if (_local_13)
            {
                _SafeStr_2199.alpha = 0.6;
            };
            var _local_16:String = (((_local_13) ? "<i>" : "") + ((_style.isAnonymous) ? "" : (("<b>" + _arg_4) + ": </b>")));
            _local_16 = (((_local_16 + ((_local_19) ? "<b>" : "")) + _arg_1.text) + ((_local_19) ? "</b>" : ""));
            _local_16 = (_local_16 + ((_local_13) ? "</i>" : ""));
            if (((_arg_1.links == null) || (_arg_1.links[0] == null)))
            {
                _SafeStr_2199.htmlText = _local_16;
            }
            else
            {
                _local_24 = -1;
                _local_25 = [];
                _local_21 = 0;
                while (_local_21 < _arg_1.links.length)
                {
                    _local_14 = _arg_1.links[_local_21][0][1];
                    _local_17 = (((('<a href="' + _local_14) + '">') + _local_14) + "</a>");
                    _local_18 = (("{" + _local_21) + "}");
                    _local_20 = _arg_1.text.indexOf(_local_18);
                    _local_24 = (_local_20 + _local_17.length);
                    _local_25.push([_local_20, _local_24]);
                    _local_16 = _local_16.replace(_local_18, _local_17);
                    _local_21++;
                };
                _SafeStr_2199.htmlText = _local_16;
            };
            var _local_15:int = Math.min(_local_22, ((_SafeStr_2199.textWidth + _arg_2.textFieldMargins.x) + _arg_2.textFieldMargins.width));
            var _local_10:int = ((_SafeStr_2199.textHeight + _arg_2.textFieldMargins.y) + _arg_2.textFieldMargins.height);
            if (!_style.isSystemStyle)
            {
                _local_10 = Math.min(108, _local_10);
            };
            if (_arg_9 != -1)
            {
                _local_10 = Math.max(_arg_9, _local_10);
            };
            _local_15 = Math.max(_local_15, _background.width);
            _local_10 = Math.max(_local_10, _background.height);
            _background.width = _local_15;
            _background.height = _local_10;
            _background.x = 0;
            _background.y = 0;
            _background.cacheAsBitmap = true;
            addChild(_background);
            if (!_style.isAnonymous)
            {
                _SafeStr_2200.x = Math.max(28, Math.min(15, userRelativePosX));
                _SafeStr_2200.y = (_local_10 - _arg_2.pointerOffsetToBubbleBottom);
                addChild(_SafeStr_2200);
            };
            if (((!(_arg_3 == null)) && (!(_arg_2.faceOffset == null))))
            {
                if (_arg_3.height > _local_10)
                {
                    _local_23 = new BitmapData(_arg_3.width, _local_10);
                    _local_23.copyPixels(_arg_3, new Rectangle(0, (_arg_3.height - _local_10), _arg_3.width, _local_10), new Point(0, 0));
                }
                else
                {
                    _local_23 = _arg_3;
                };
                _SafeStr_2201 = new Bitmap(_local_23);
                _SafeStr_2201.x = (_arg_2.faceOffset.x - (_local_23.width / 2));
                _SafeStr_2201.y = Math.max(1, (_arg_2.faceOffset.y - (_local_23.height / 2)));
                addChild(_SafeStr_2201);
            };
            _SafeStr_2199.width = Math.min(_local_12, (_SafeStr_2199.textWidth + _style.textFieldMargins.width));
            _SafeStr_2199.height = (_SafeStr_2199.textHeight + _style.textFieldMargins.height);
            _SafeStr_2199.x = _arg_2.textFieldMargins.x;
            _SafeStr_2199.y = _arg_2.textFieldMargins.y;
            addChild(_SafeStr_2199);
            if (((!(_style.isSystemStyle)) && (_SafeStr_2199.textHeight > 108)))
            {
                _SafeStr_664 = new Sprite();
                _SafeStr_664.graphics.clear();
                _SafeStr_664.graphics.beginFill(0xFFFFFF);
                _SafeStr_664.graphics.drawRect(0, 0, (_SafeStr_2199.textWidth + 5), (108 - _arg_2.textFieldMargins.height));
                _SafeStr_2199.mask = _SafeStr_664;
                addChild(_SafeStr_664);
            };
            this.addEventListener("addedToStage", onAddedToStage);
        }

        public function dispose():void
        {
            this.removeEventListener("addedToStage", onAddedToStage);
            this.removeEventListener("click", onMouseClick);
            if (_SafeStr_664)
            {
                removeChild(_SafeStr_664);
            };
            if (_SafeStr_2199)
            {
                _SafeStr_2199.removeEventListener("link", onTextLinkEvent);
            };
            removeChild(_SafeStr_2199);
            if (((!(_SafeStr_2201 == null)) && (!(_style.faceOffset == null))))
            {
                removeChild(_SafeStr_2201);
            };
            if (((_SafeStr_2200) && (_SafeStr_2200.parent)))
            {
                removeChild(_SafeStr_2200);
            };
            removeChild(_background);
            _SafeStr_664 = null;
            _SafeStr_2199 = null;
            _SafeStr_2201 = null;
            _SafeStr_2200 = null;
            _background = null;
            _style = null;
        }

        private function onTextLinkEvent(_arg_1:TextEvent):void
        {
            if (((_arg_1.text) && (_arg_1.text.length > 0)))
            {
                _SafeStr_659.context.createLinkEvent(_arg_1.text);
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
            repositionPointer();
        }

        public function update(_arg_1:uint):void
        {
            var _local_2:uint;
            _SafeStr_2205 = (_SafeStr_2205 + _arg_1);
            if (((!(proxyX == _SafeStr_2207)) || (!(y == _SafeStr_2208))))
            {
                _local_2 = (_SafeStr_2205 - _SafeStr_2206);
                if (_local_2 < 150)
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
            repositionPointer();
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

        public function drawToBitmap(_arg_1:BitmapData):void
        {
            _arg_1.draw(this);
        }


    }
}

