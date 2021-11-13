package com.sulake.habbo.room.object.visualization.avatar
{
    import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.avatar.IAvatarEffectListener;
    import com.sulake.core.utils.Map;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.room.object.visualization.avatar.additions.IAvatarAddition;
    import com.sulake.room.data.RoomObjectSpriteData;
    import com.sulake.habbo.avatar.animation.IAnimationLayerData;
    import flash.geom.Rectangle;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
    import com.sulake.habbo.avatar.animation.IAvatarDataContainer;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.habbo.room.object.visualization.avatar.additions.FloatingIdleZ;
    import com.sulake.habbo.room.object.visualization.avatar.additions.MutedBubble;
    import com.sulake.habbo.room.object.visualization.avatar.additions.TypingBubble;
    import com.sulake.habbo.room.object.visualization.avatar.additions.GuideStatusBubble;
    import com.sulake.habbo.room.object.visualization.avatar.additions.GameClickTarget;
    import com.sulake.habbo.room.object.visualization.avatar.additions.NumberBubble;
    import com.sulake.habbo.room.object.visualization.avatar.additions._SafeStr_183;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.core.assets.IAsset;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.IRoomGeometry;
    import flash.display.BitmapData;
    import flash.filters.BitmapFilter;
    import flash.filters.GlowFilter;
    import flash.geom.Point;
    import com.sulake.room.object.enum.RoomObjectSpriteType;
    import com.sulake.habbo.utils.BitmapHelper;
    import com.sulake.habbo.avatar.enum.AvatarAction;

    public class AvatarVisualization extends RoomObjectSpriteVisualization implements IAvatarImageListener, IAvatarEffectListener
    {

        private static const AVATAR_SPRITE_TAG:String = "avatar";
        private static const AVATAR_SPRITE_DEFAULT_DEPTH:Number = -0.01;
        private static const AVATAR_OWN_DEPTH_ADJUST:Number = 0.001;
        private static const AVATAR_SPRITE_LAYING_DEPTH:Number = -0.409;
        private static const BASE_Y_SCALE:int = 1000;
        private static const ANIMATION_FRAME_UPDATE_INTERVAL:int = 2;
        private static const DEFAULT_CANVAS_OFFSETS:Array = [0, 0, 0];
        private static const SNOWBOARDING_EFFECT:int = 97;
        private static const MAX_AVATARS_WITH_EFFECT:int = 3;
        private static const SPRITE_INDEX_AVATAR:int = 0;
        private static const _SafeStr_3242:int = 1;
        private static const INITIAL_RESERVED_SPRITES:int = 2;
        private static const ADDITION_ID_IDLE_BUBBLE:int = 1;
        private static const ADDITION_ID_TYPING_BUBBLE:int = 2;
        private static const ADDITION_ID_EXPRESSION:int = 3;
        private static const ADDITION_ID_NUMBER_BUBBLE:int = 4;
        private static const ADDITION_ID_GAME_CLICK_TARGET:int = 5;
        private static const ADDITION_ID_MUTED_BUBBLE:int = 6;
        private static const ADDITION_ID_GUIDE_STATUS_BUBBLE:int = 7;

        private const _SafeStr_3243:int = 41;

        private var _lastUpdateTime:int = -1000;
        private var _SafeStr_3244:AvatarVisualizationData = null;
        private var _avatars:Map;
        private var _SafeStr_3245:Map;
        private var _updatesUntilFrameUpdate:int = 0;
        private var _SafeStr_1388:Boolean;
        private var _SafeStr_1382:String;
        private var _SafeStr_1926:String;
        private var _SafeStr_3246:int = 0;
        private var _shadowAsset:BitmapDataAsset;
        private var _forceUpdate:Boolean;
        private var _headAngle:int = -1;
        private var _angle:int = -1;
        private var _SafeStr_3247:int = -1;
        private var _SafeStr_3248:int = 2;
        private var _SafeStr_3249:Map;
        private var _SafeStr_3250:int = -1;
        private var _posture:String = "";
        private var _SafeStr_3251:String = "";
        private var _SafeStr_3252:Boolean = false;
        private var _SafeStr_3253:Boolean = false;
        private var _SafeStr_3254:Boolean = false;
        private var _SafeStr_3255:int = 0;
        private var _SafeStr_3256:int = 0;
        private var _SafeStr_3257:int = 0;
        private var _SafeStr_3258:int = 0;
        private var _SafeStr_3259:Boolean = false;
        private var _SafeStr_3260:int = -1;
        private var _SafeStr_3261:int = 0;
        private var _SafeStr_3262:int = 0;
        private var _SafeStr_3263:int = 0;
        private var _geometryOffset:int = 0;
        private var _SafeStr_3264:int = 0;
        private var _SafeStr_3265:Boolean = false;
        private var _SafeStr_3266:Boolean = false;
        private var _SafeStr_3267:Boolean = false;
        private var _SafeStr_3268:IAvatarImage = null;
        private var _SafeStr_3269:Boolean = false;
        private var _disposed:Boolean;

        public function AvatarVisualization()
        {
            _avatars = new Map();
            _SafeStr_3245 = new Map();
            _SafeStr_1388 = false;
        }

        override public function dispose():void
        {
            if (_avatars != null)
            {
                resetImages();
                _avatars.dispose();
                _SafeStr_3245.dispose();
                _avatars = null;
            };
            _SafeStr_3244 = null;
            _shadowAsset = null;
            if (_SafeStr_3249)
            {
                for each (var _local_1:IAvatarAddition in _SafeStr_3249)
                {
                    _local_1.dispose();
                };
                _SafeStr_3249 = null;
            };
            super.dispose();
            _disposed = true;
        }

        override public function getSpriteList():Array
        {
            var _local_17:RoomObjectSpriteData;
            var _local_6:RoomObjectSpriteData;
            var _local_11:IAnimationLayerData;
            var _local_18:int;
            var _local_1:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            var _local_19:int;
            var _local_8:int;
            var _local_7:String;
            var _local_2:BitmapDataAsset;
            var _local_12:Rectangle;
            var _local_5:String;
            if (_SafeStr_3268 == null)
            {
                return (null);
            };
            var _local_3:IRoomObjectSprite = getSprite(1);
            if (_local_3)
            {
                _local_17 = new RoomObjectSpriteData();
                _local_17.alpha = _local_3.alpha;
                _local_17.x = _local_3.offsetX;
                _local_17.y = _local_3.offsetY;
                _local_17.name = _local_3.assetName;
                _local_17.width = _local_3.width;
                _local_17.height = _local_3.height;
            };
            var _local_9:Array = _SafeStr_3268.getServerRenderData();
            for each (var _local_10:ISpriteDataContainer in _SafeStr_3268.getSprites())
            {
                _local_6 = new RoomObjectSpriteData();
                _local_11 = _SafeStr_3268.getLayerData(_local_10);
                _local_18 = 0;
                _local_1 = _SafeStr_3268.getDirection();
                _local_13 = _local_10.getDirectionOffsetX(_local_1);
                _local_14 = _local_10.getDirectionOffsetY(_local_1);
                _local_15 = _local_10.getDirectionOffsetZ(_local_1);
                _local_19 = 0;
                if (_local_10.hasDirections)
                {
                    _local_19 = _local_1;
                };
                if (_local_11 != null)
                {
                    _local_18 = _local_11.animationFrame;
                    _local_13 = (_local_13 + _local_11.dx);
                    _local_14 = (_local_14 + _local_11.dy);
                    _local_19 = (_local_19 + _local_11.directionOffset);
                };
                _local_8 = 64;
                if (_local_8 < 48)
                {
                    _local_13 = int((_local_13 / 2));
                    _local_14 = int((_local_14 / 2));
                };
                if (_local_19 < 0)
                {
                    _local_19 = (_local_19 + 8);
                }
                else
                {
                    if (_local_19 > 7)
                    {
                        _local_19 = (_local_19 - 8);
                    };
                };
                _local_7 = ((((((_SafeStr_3268.getScale() + "_") + _local_10.member) + "_") + _local_19) + "_") + _local_18);
                _local_2 = _SafeStr_3268.getAsset(_local_7);
                if (_local_2 != null)
                {
                    _local_6.x = ((-(_local_2.offset.x) - (_local_8 / 2)) + _local_13);
                    _local_6.y = (-(_local_2.offset.y) + _local_14);
                    if (_local_10.hasStaticY)
                    {
                        _local_6.y = (_local_6.y + ((_SafeStr_3264 * _local_8) / (2 * 1000)));
                    };
                    if (_local_10.ink == 33)
                    {
                        _local_6.blendMode = "add";
                    };
                    _local_6.name = _local_7;
                    if (_SafeStr_3266)
                    {
                        _local_6.z = (-0.409 - ((0.001 * spriteCount) * _local_15));
                    }
                    else
                    {
                        _local_6.z = ((-0.001 * spriteCount) * _local_15);
                    };
                    _local_12 = _local_2.rectangle;
                    if (_local_12 == null)
                    {
                        _local_6.width = 60;
                        _local_6.height = 60;
                    }
                    else
                    {
                        _local_6.width = _local_12.width;
                        _local_6.height = _local_12.height;
                    };
                    _local_9.push(_local_6);
                };
            };
            var _local_4:IAvatarDataContainer = _SafeStr_3268.avatarSpriteData;
            if (((!(_local_4 == null)) && (_local_4.paletteIsGrayscale)))
            {
                _local_5 = _local_4.reds[0].toString();
                for each (var _local_16:RoomObjectSpriteData in _local_9)
                {
                    if (((_local_16.name.indexOf("h_std_fx") == -1) && (_local_16.name.indexOf("h_std_sd") == -1)))
                    {
                        _local_16.color = _local_5;
                    };
                };
            };
            if (_local_17)
            {
                _local_9.push(_local_17);
            };
            return (_local_9);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get angle():int
        {
            return (_angle);
        }

        public function get posture():String
        {
            return (_posture);
        }

        override public function initialize(_arg_1:IRoomObjectVisualizationData):Boolean
        {
            _SafeStr_3244 = (_arg_1 as AvatarVisualizationData);
            createSprites(2);
            return (true);
        }

        private function updateModel(_arg_1:IRoomObjectModel, _arg_2:Number, _arg_3:Boolean):Boolean
        {
            var _local_7:Boolean;
            var _local_4:Boolean;
            var _local_8:int;
            var _local_6:String;
            var _local_9:IAvatarAddition;
            var _local_5:String;
            if (_arg_1.getUpdateID() != _SafeStr_3270)
            {
                _local_7 = false;
                _local_4 = false;
                _local_8 = 0;
                _local_6 = "";
                _local_4 = ((_arg_1.getNumber("figure_talk") > 0) && (_arg_3));
                if (_local_4 != _SafeStr_3252)
                {
                    _SafeStr_3252 = _local_4;
                    _local_7 = true;
                };
                _local_8 = _arg_1.getNumber("figure_expression");
                if (_local_8 != _SafeStr_3255)
                {
                    _SafeStr_3255 = _local_8;
                    _local_7 = true;
                };
                _local_4 = (_arg_1.getNumber("figure_sleep") > 0);
                if (_local_4 != _SafeStr_3253)
                {
                    _SafeStr_3253 = _local_4;
                    _local_7 = true;
                };
                _local_4 = ((_arg_1.getNumber("figure_blink") > 0) && (_arg_3));
                if (_local_4 != _SafeStr_3254)
                {
                    _SafeStr_3254 = _local_4;
                    _local_7 = true;
                };
                _local_8 = _arg_1.getNumber("figure_gesture");
                if (_local_8 != _SafeStr_3256)
                {
                    _SafeStr_3256 = _local_8;
                    _local_7 = true;
                };
                _local_6 = _arg_1.getString("figure_posture");
                if (_local_6 != _posture)
                {
                    _posture = _local_6;
                    _local_7 = true;
                };
                _local_6 = _arg_1.getString("figure_posture_parameter");
                if (_local_6 != _SafeStr_3251)
                {
                    _SafeStr_3251 = _local_6;
                    _local_7 = true;
                };
                _local_4 = (_arg_1.getNumber("figure_can_stand_up") > 0);
                if (_local_4 != _SafeStr_3265)
                {
                    _SafeStr_3265 = _local_4;
                    _local_7 = true;
                };
                _local_8 = (_arg_1.getNumber("figure_vertical_offset") * 1000);
                if (_local_8 != _SafeStr_3264)
                {
                    _SafeStr_3264 = _local_8;
                    _local_7 = true;
                };
                _local_8 = _arg_1.getNumber("figure_dance");
                if (_local_8 != _SafeStr_3257)
                {
                    _SafeStr_3257 = _local_8;
                    _local_7 = true;
                };
                _local_8 = _arg_1.getNumber("figure_effect");
                if (_local_8 != _SafeStr_3261)
                {
                    _SafeStr_3261 = _local_8;
                    _local_7 = true;
                };
                _local_8 = _arg_1.getNumber("figure_carry_object");
                if (_local_8 != _SafeStr_3262)
                {
                    _SafeStr_3262 = _local_8;
                    _local_7 = true;
                };
                _local_8 = _arg_1.getNumber("figure_use_object");
                if (_local_8 != _SafeStr_3263)
                {
                    _SafeStr_3263 = _local_8;
                    _local_7 = true;
                };
                _local_8 = _arg_1.getNumber("head_direction");
                if (_local_8 != _headAngle)
                {
                    _headAngle = _local_8;
                    _local_7 = true;
                };
                if (((_SafeStr_3262 > 0) && (_arg_1.getNumber("figure_use_object") > 0)))
                {
                    if (_SafeStr_3263 != _SafeStr_3262)
                    {
                        _SafeStr_3263 = _SafeStr_3262;
                        _local_7 = true;
                    };
                }
                else
                {
                    if (_SafeStr_3263 != 0)
                    {
                        _SafeStr_3263 = 0;
                        _local_7 = true;
                    };
                };
                _local_9 = (getAddition(1) as FloatingIdleZ);
                if (_SafeStr_3253)
                {
                    if (!_local_9)
                    {
                        _local_9 = addAddition(new FloatingIdleZ(1, this));
                    };
                    _local_7 = true;
                }
                else
                {
                    if (_local_9)
                    {
                        removeAddition(1);
                    };
                };
                _local_4 = (_arg_1.getNumber("figure_is_muted") > 0);
                _local_9 = (getAddition(6) as MutedBubble);
                if (_local_4)
                {
                    if (!_local_9)
                    {
                        _local_9 = addAddition(new MutedBubble(6, this));
                    };
                    removeAddition(2);
                    _local_7 = true;
                }
                else
                {
                    if (_local_9)
                    {
                        removeAddition(6);
                        _local_7 = true;
                    };
                    _local_4 = (_arg_1.getNumber("figure_is_typing") > 0);
                    _local_9 = (getAddition(2) as TypingBubble);
                    if (_local_4)
                    {
                        if (!_local_9)
                        {
                            _local_9 = addAddition(new TypingBubble(2, this));
                        };
                        _local_7 = true;
                    }
                    else
                    {
                        if (_local_9)
                        {
                            removeAddition(2);
                        };
                    };
                };
                _local_8 = _arg_1.getNumber("figure_guide_status");
                if (_local_8 != 0)
                {
                    removeAddition(7);
                    addAddition(new GuideStatusBubble(7, this, _local_8));
                    _local_7 = true;
                }
                else
                {
                    if ((getAddition(7) as GuideStatusBubble) != null)
                    {
                        removeAddition(7);
                        _local_7 = true;
                    };
                };
                _local_4 = (_arg_1.getNumber("figure_is_playing_game") > 0);
                _local_9 = (getAddition(5) as GameClickTarget);
                if (_local_4)
                {
                    if (!_local_9)
                    {
                        _local_9 = addAddition(new GameClickTarget(5));
                    };
                    _local_7 = true;
                }
                else
                {
                    if (_local_9)
                    {
                        removeAddition(5);
                    };
                };
                _local_8 = _arg_1.getNumber("figure_number_value");
                _local_9 = (getAddition(4) as NumberBubble);
                if (_local_8 > 0)
                {
                    if (!_local_9)
                    {
                        _local_9 = addAddition(new NumberBubble(4, _local_8, this));
                    };
                    _local_7 = true;
                }
                else
                {
                    if (_local_9)
                    {
                        removeAddition(4);
                    };
                };
                _local_8 = _arg_1.getNumber("figure_expression");
                _local_9 = getAddition(3);
                if (_local_8 > 0)
                {
                    if (!_local_9)
                    {
                        _local_9 = _SafeStr_183.make(3, _local_8, this);
                        if (_local_9)
                        {
                            addAddition(_local_9);
                        };
                    };
                }
                else
                {
                    if (_local_9)
                    {
                        removeAddition(3);
                    };
                };
                validateActions(_arg_2);
                _local_6 = _arg_1.getString("gender");
                if (_local_6 != _SafeStr_1926)
                {
                    _SafeStr_1926 = _local_6;
                    _local_7 = true;
                };
                _local_5 = _arg_1.getString("figure");
                if (updateFigure(_local_5))
                {
                    _local_7 = true;
                };
                if (_arg_1.hasNumber("figure_sign"))
                {
                    _local_8 = _arg_1.getNumber("figure_sign");
                    if (_local_8 != _SafeStr_3260)
                    {
                        _local_7 = true;
                        _SafeStr_3260 = _local_8;
                    };
                };
                _local_4 = (_arg_1.getNumber("figure_highlight_enable") > 0);
                if (_local_4 != _SafeStr_3259)
                {
                    _SafeStr_3259 = _local_4;
                    _local_7 = true;
                };
                if (_SafeStr_3259)
                {
                    _local_8 = _arg_1.getNumber("figure_highlight");
                    if (_local_8 != _SafeStr_3258)
                    {
                        _SafeStr_3258 = _local_8;
                        _local_7 = true;
                    };
                };
                _local_4 = (_arg_1.getNumber("own_user") > 0);
                if (_local_4 != _SafeStr_3269)
                {
                    _SafeStr_3269 = _local_4;
                    _local_7 = true;
                };
                _SafeStr_3270 = _arg_1.getUpdateID();
                return (_local_7);
            };
            return (false);
        }

        private function updateFigure(_arg_1:String):Boolean
        {
            if (_SafeStr_1382 != _arg_1)
            {
                _SafeStr_1382 = _arg_1;
                resetImages();
                return (true);
            };
            return (false);
        }

        private function resetImages():void
        {
            var _local_2:IAvatarImage;
            for each (_local_2 in _avatars)
            {
                if (_local_2)
                {
                    _local_2.dispose();
                };
            };
            for each (_local_2 in _SafeStr_3245)
            {
                if (_local_2)
                {
                    _local_2.dispose();
                };
            };
            _avatars.reset();
            _SafeStr_3245.reset();
            _SafeStr_3268 = null;
            var _local_1:IRoomObjectSprite = getSprite(0);
            if (_local_1 != null)
            {
                _local_1.asset = null;
                _local_1.alpha = 0xFF;
            };
        }

        private function validateActions(_arg_1:Number):void
        {
            var _local_2:int;
            if (_arg_1 < 48)
            {
                _SafeStr_3254 = false;
            };
            if (((_posture == "sit") || (_posture == "lay")))
            {
                _geometryOffset = (_arg_1 / 2);
            }
            else
            {
                _geometryOffset = 0;
            };
            _SafeStr_3267 = false;
            _SafeStr_3266 = false;
            if (_posture == "lay")
            {
                _SafeStr_3266 = true;
                _local_2 = int(_SafeStr_3251);
                if (_local_2 < 0)
                {
                    _SafeStr_3267 = true;
                };
            };
        }

        private function getAvatarImage(_arg_1:Number, _arg_2:int):IAvatarImage
        {
            var _local_4:IAvatarImage;
            var _local_5:IAvatarImage;
            var _local_3:String = ("avatarImage" + _arg_1.toString());
            if (_arg_2 == 0)
            {
                _local_4 = (_avatars.getValue(_local_3) as IAvatarImage);
            }
            else
            {
                _local_3 = (_local_3 + ("-" + _arg_2));
                _local_4 = (_SafeStr_3245.getValue(_local_3) as IAvatarImage);
                if (_local_4)
                {
                    _local_4.forceActionUpdate();
                };
            };
            if (_local_4 == null)
            {
                _local_4 = _SafeStr_3244.getAvatar(_SafeStr_1382, _arg_1, _SafeStr_1926, this, this);
                if (_local_4 != null)
                {
                    if (_arg_2 == 0)
                    {
                        _avatars.add(_local_3, _local_4);
                    }
                    else
                    {
                        if (_SafeStr_3245.length >= 3)
                        {
                            _local_5 = _SafeStr_3245.remove(_SafeStr_3245.getKey(0));
                            if (_local_5)
                            {
                                _local_5.dispose();
                            };
                        };
                        _SafeStr_3245.add(_local_3, _local_4);
                    };
                };
            };
            return (_local_4);
        }

        public function getAvatarRendererAsset(_arg_1:String):IAsset
        {
            return ((_SafeStr_3244) ? _SafeStr_3244.getAvatarRendererAsset(_arg_1) : null);
        }

        private function updateObject(_arg_1:IRoomObject, _arg_2:IRoomGeometry, _arg_3:Boolean, _arg_4:Boolean=false):Boolean
        {
            var _local_6:Boolean;
            var _local_5:int;
            var _local_7:int;
            if ((((_arg_4) || (!(_SafeStr_3271 == _arg_1.getUpdateID()))) || (!(_SafeStr_3250 == _arg_2.updateId))))
            {
                _local_6 = _arg_3;
                _local_5 = (_arg_1.getDirection().x - _arg_2.direction.x);
                _local_5 = (((_local_5 % 360) + 360) % 360);
                if (((_posture == "sit") && (_SafeStr_3265)))
                {
                    _local_5 = (_local_5 - ((_local_5 % 90) - 45));
                };
                _local_7 = _headAngle;
                if (_posture == "float")
                {
                    _local_7 = _local_5;
                }
                else
                {
                    _local_7 = (_local_7 - _arg_2.direction.x);
                };
                _local_7 = (((_local_7 % 360) + 360) % 360);
                if (((((_posture == "sit") && (_SafeStr_3265)) || (_posture == "swdieback")) || (_posture == "swdiefront")))
                {
                    _local_7 = (_local_7 - ((_local_7 % 90) - 45));
                };
                if (((!(_local_5 == _angle)) || (_arg_4)))
                {
                    _local_6 = true;
                    _angle = _local_5;
                    _local_5 = (_local_5 - 112.5);
                    _local_5 = ((_local_5 + 360) % 360);
                    _SafeStr_3268.setDirectionAngle("full", _local_5);
                };
                if (((!(_local_7 == _SafeStr_3247)) || (_arg_4)))
                {
                    _local_6 = true;
                    _SafeStr_3247 = _local_7;
                    if (_SafeStr_3247 != _angle)
                    {
                        _local_7 = (_local_7 - 112.5);
                        _local_7 = ((_local_7 + 360) % 360);
                        _SafeStr_3268.setDirectionAngle("head", _local_7);
                    };
                };
                _SafeStr_3271 = _arg_1.getUpdateID();
                _SafeStr_3250 = _arg_2.updateId;
                return (_local_6);
            };
            return (false);
        }

        private function updateShadow(_arg_1:Number):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_5:IRoomObjectSprite = getSprite(1);
            _shadowAsset = null;
            var _local_4:Boolean = (((_posture == "mv") || (_posture == "std")) || ((_posture == "sit") && (_SafeStr_3265)));
            if (_SafeStr_3261 == 97)
            {
                _local_4 = false;
            };
            if (_local_4)
            {
                _local_5.visible = true;
                if (((_shadowAsset == null) || (!(_arg_1 == _SafeStr_3272))))
                {
                    _local_2 = 0;
                    _local_3 = 0;
                    if (_arg_1 < 48)
                    {
                        _local_5.libraryAssetName = "sh_std_sd_1_0_0";
                        _shadowAsset = _SafeStr_3268.getAsset(_local_5.libraryAssetName);
                        _local_2 = -8;
                        _local_3 = ((_SafeStr_3265) ? 6 : -3);
                    }
                    else
                    {
                        _local_5.libraryAssetName = "h_std_sd_1_0_0";
                        _shadowAsset = _SafeStr_3268.getAsset(_local_5.libraryAssetName);
                        _local_2 = -17;
                        _local_3 = ((_SafeStr_3265) ? 10 : -7);
                    };
                    if (_shadowAsset != null)
                    {
                        _local_5.asset = (_shadowAsset.content as BitmapData);
                        _local_5.offsetX = _local_2;
                        _local_5.offsetY = _local_3;
                        _local_5.alpha = 50;
                        _local_5.relativeDepth = 1;
                    }
                    else
                    {
                        _local_5.visible = false;
                    };
                };
            }
            else
            {
                _shadowAsset = null;
                _local_5.visible = false;
            };
        }

        override public function update(_arg_1:IRoomGeometry, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean):void
        {
            var _local_5:int;
            var _local_10:IRoomObjectSprite;
            var _local_21:IRoomObjectSprite;
            var _local_17:Array;
            var _local_22:Boolean;
            var _local_26:BitmapData;
            var _local_35:BitmapFilter;
            var _local_33:int;
            var _local_27:int;
            var _local_28:IAnimationLayerData;
            var _local_13:int;
            var _local_12:int;
            var _local_15:IAnimationLayerData;
            var _local_41:int;
            var _local_16:int;
            var _local_18:int;
            var _local_20:int;
            var _local_25:int;
            var _local_30:String;
            var _local_6:BitmapDataAsset;
            var _local_31:int;
            var _local_8:Boolean;
            var _local_37:int;
            var _local_36:int;
            var _local_38:IRoomObject = object;
            if (_local_38 == null)
            {
                return;
            };
            if (_arg_1 == null)
            {
                return;
            };
            if (_SafeStr_3244 == null)
            {
                return;
            };
            if (_arg_2 < (_lastUpdateTime + 41))
            {
                return;
            };
            _lastUpdateTime = (_lastUpdateTime + 41);
            if ((_lastUpdateTime + 41) < _arg_2)
            {
                _lastUpdateTime = (_arg_2 - 41);
            };
            var _local_23:IRoomObjectModel = _local_38.getModel();
            var _local_11:Number = _arg_1.scale;
            var _local_7:Boolean;
            var _local_19:Boolean;
            var _local_9:Boolean;
            var _local_34:int = _SafeStr_3261;
            var _local_40:Boolean;
            var _local_32:Boolean = updateModel(_local_23, _local_11, _arg_3);
            if (_forceUpdate)
            {
                resetImages();
                _forceUpdate = false;
            };
            if ((((_local_32) || (!(_local_11 == _SafeStr_3272))) || (_SafeStr_3268 == null)))
            {
                if (_local_11 != _SafeStr_3272)
                {
                    _local_19 = true;
                    validateActions(_local_11);
                };
                if (_local_34 != _SafeStr_3261)
                {
                    _local_40 = true;
                };
                if ((((_local_19) || (_SafeStr_3268 == null)) || (_local_40)))
                {
                    _SafeStr_3268 = getAvatarImage(_local_11, _SafeStr_3261);
                    if (_SafeStr_3268 == null)
                    {
                        return;
                    };
                    _local_7 = true;
                    _local_10 = getSprite(0);
                    if ((((_local_10) && (_SafeStr_3268)) && (_SafeStr_3268.isPlaceholder())))
                    {
                        _local_10.alpha = 150;
                    }
                    else
                    {
                        if (_local_10)
                        {
                            _local_10.alpha = 0xFF;
                        };
                    };
                };
                if (_SafeStr_3268 == null)
                {
                    return;
                };
                if (((_local_40) && (_SafeStr_3268.animationHasResetOnToggle)))
                {
                    _SafeStr_3268.resetAnimationFrameCounter();
                };
                updateShadow(_local_11);
                _local_9 = updateObject(_local_38, _arg_1, _arg_3, true);
                updateActions(_SafeStr_3268);
                if (_SafeStr_3249)
                {
                    _local_5 = _SafeStr_3248;
                    for each (var _local_24:IAvatarAddition in _SafeStr_3249)
                    {
                        _local_24.update(getSprite(_local_5++), _local_11);
                    };
                };
                _SafeStr_3272 = _local_11;
            }
            else
            {
                _local_9 = updateObject(_local_38, _arg_1, _arg_3);
            };
            if (_SafeStr_3249)
            {
                _local_5 = _SafeStr_3248;
                for each (_local_24 in _SafeStr_3249)
                {
                    if (_local_24.animate(getSprite(_local_5++)))
                    {
                        increaseUpdateId();
                    };
                };
            };
            var _local_39:Boolean = (((_local_9) || (_local_32)) || (_local_19));
            var _local_29:Boolean = (((_SafeStr_1388) || (_SafeStr_3246 > 0)) && (_arg_3));
            if (_local_39)
            {
                _SafeStr_3246 = 2;
            };
            if (((_local_39) || (_local_29)))
            {
                increaseUpdateId();
                _SafeStr_3246--;
                _updatesUntilFrameUpdate--;
                if (((((_updatesUntilFrameUpdate <= 0) || (_local_19)) || (_local_32)) || (_local_7)))
                {
                    _SafeStr_3268.updateAnimationByFrames(1);
                    _updatesUntilFrameUpdate = 2;
                }
                else
                {
                    return;
                };
                _local_17 = _SafeStr_3268.getCanvasOffsets();
                if (((_local_17 == null) || (_local_17.length < 3)))
                {
                    _local_17 = DEFAULT_CANVAS_OFFSETS;
                };
                _local_21 = getSprite(0);
                if (_local_21 != null)
                {
                    _local_22 = ((_local_23.getNumber("figure_highlight_enable") == 1) && (_local_23.getNumber("figure_highlight") == 1));
                    _local_26 = _SafeStr_3268.getImage("full", _local_22);
                    if (_local_26 != null)
                    {
                        if (_local_22)
                        {
                            _local_35 = new GlowFilter(0xFFFFFF, 1, 6, 6);
                            _local_26.applyFilter(_local_26, _local_26.rect, new Point(0, 0), _local_35);
                        };
                        _local_21.asset = _local_26;
                    };
                    if (_local_21.asset)
                    {
                        _local_21.offsetX = ((((-1 * _local_11) / 2) + _local_17[0]) - ((_local_21.asset.width - _local_11) / 2));
                        _local_21.offsetY = (((-(_local_21.asset.height) + (_local_11 / 4)) + _local_17[1]) + _geometryOffset);
                        if (((_posture == "swdieback") || (_posture == "swdiefront")))
                        {
                            _local_21.offsetY = (_local_21.offsetY + ((20 * _local_11) / 32));
                        };
                    };
                    if (_SafeStr_3266)
                    {
                        if (_SafeStr_3267)
                        {
                            _local_21.relativeDepth = -0.5;
                        }
                        else
                        {
                            _local_21.relativeDepth = (-0.409 + _local_17[2]);
                        };
                    }
                    else
                    {
                        _local_21.relativeDepth = (-0.01 + _local_17[2]);
                    };
                    if (_SafeStr_3269)
                    {
                        _local_21.relativeDepth = (_local_21.relativeDepth - 0.001);
                        _local_21.spriteType = RoomObjectSpriteType._SafeStr_625;
                    }
                    else
                    {
                        _local_21.spriteType = RoomObjectSpriteType.AVATAR;
                    };
                };
                _local_24 = (getAddition(2) as TypingBubble);
                if (_local_24)
                {
                    if (!_SafeStr_3266)
                    {
                        TypingBubble(_local_24).relativeDepth = ((-0.01 - 0.01) + _local_17[2]);
                    }
                    else
                    {
                        TypingBubble(_local_24).relativeDepth = ((-0.409 - 0.01) + _local_17[2]);
                    };
                };
                _SafeStr_1388 = _SafeStr_3268.isAnimating();
                _local_33 = 2;
                _local_27 = _SafeStr_3268.getDirection();
                for each (var _local_14:ISpriteDataContainer in _SafeStr_3268.getSprites())
                {
                    if (_local_14.id == "avatar")
                    {
                        _local_21 = getSprite(0);
                        _local_28 = _SafeStr_3268.getLayerData(_local_14);
                        _local_13 = _local_14.getDirectionOffsetX(_local_27);
                        _local_12 = _local_14.getDirectionOffsetY(_local_27);
                        if (_local_28 != null)
                        {
                            _local_13 = (_local_13 + _local_28.dx);
                            _local_12 = (_local_12 + _local_28.dy);
                        };
                        if (_local_11 < 48)
                        {
                            _local_13 = int((_local_13 / 2));
                            _local_12 = int((_local_12 / 2));
                        };
                        if (!_SafeStr_3265)
                        {
                            _local_21.offsetX = (_local_21.offsetX + _local_13);
                            _local_21.offsetY = (_local_21.offsetY + _local_12);
                        };
                    }
                    else
                    {
                        _local_21 = getSprite(_local_33);
                        if (_local_21 != null)
                        {
                            _local_21.alphaTolerance = 0x0100;
                            _local_21.visible = true;
                            _local_15 = _SafeStr_3268.getLayerData(_local_14);
                            _local_41 = 0;
                            _local_16 = _local_14.getDirectionOffsetX(_local_27);
                            _local_18 = _local_14.getDirectionOffsetY(_local_27);
                            _local_20 = _local_14.getDirectionOffsetZ(_local_27);
                            _local_25 = 0;
                            if (_local_14.hasDirections)
                            {
                                _local_25 = _local_27;
                            };
                            if (_local_15 != null)
                            {
                                _local_41 = _local_15.animationFrame;
                                _local_16 = (_local_16 + _local_15.dx);
                                _local_18 = (_local_18 + _local_15.dy);
                                _local_25 = (_local_25 + _local_15.directionOffset);
                            };
                            if (_local_11 < 48)
                            {
                                _local_16 = int((_local_16 / 2));
                                _local_18 = int((_local_18 / 2));
                            };
                            if (_local_25 < 0)
                            {
                                _local_25 = (_local_25 + 8);
                            }
                            else
                            {
                                if (_local_25 > 7)
                                {
                                    _local_25 = (_local_25 - 8);
                                };
                            };
                            _local_30 = ((((((_SafeStr_3268.getScale() + "_") + _local_14.member) + "_") + _local_25) + "_") + _local_41);
                            _local_6 = _SafeStr_3268.getAsset(_local_30);
                            _local_31 = ((_SafeStr_3268.getScale() == "sh") ? 32 : 64);
                            _local_8 = false;
                            if (_local_6 == null)
                            {
                                if (_SafeStr_3268.getScale() == "sh")
                                {
                                    _local_30 = ((((("h_" + _local_14.member) + "_") + _local_25) + "_") + _local_41);
                                    _local_6 = _SafeStr_3268.getAsset(_local_30);
                                    _local_8 = true;
                                };
                                if (_local_6 == null) continue;
                            };
                            _local_21.asset = ((_local_8) ? BitmapHelper.resampleBitmapData((_local_6.content as BitmapData), 0.5) : (_local_6.content as BitmapData));
                            _local_37 = int(((_local_8) ? (_local_6.offset.x / 2) : _local_6.offset.x));
                            _local_36 = int(((_local_8) ? (_local_6.offset.y / 2) : _local_6.offset.y));
                            _local_21.offsetX = ((-(_local_37) - (_local_31 / 2)) + _local_16);
                            _local_21.offsetY = (-(_local_36) + _local_18);
                            if (_local_14.hasStaticY)
                            {
                                _local_21.offsetY = (_local_21.offsetY + ((_SafeStr_3264 * _local_11) / (2 * 1000)));
                            }
                            else
                            {
                                _local_21.offsetY = (_local_21.offsetY + _geometryOffset);
                            };
                            if (_SafeStr_3266)
                            {
                                _local_21.relativeDepth = (-0.409 - ((0.001 * spriteCount) * _local_20));
                            }
                            else
                            {
                                _local_21.relativeDepth = (-0.01 - ((0.001 * spriteCount) * _local_20));
                            };
                            if (_local_14.ink == 33)
                            {
                                _local_21.blendMode = "add";
                            }
                            else
                            {
                                _local_21.blendMode = "normal";
                            };
                        };
                        _local_33++;
                    };
                };
            };
        }

        private function updateActions(_arg_1:IAvatarImage):void
        {
            var _local_3:String;
            var _local_5:IRoomObjectSprite;
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.initActionAppends();
            _arg_1.appendAction("posture", _posture, _SafeStr_3251);
            if (_SafeStr_3256 > 0)
            {
                _arg_1.appendAction("gest", AvatarAction.getGesture(_SafeStr_3256));
            };
            if (_SafeStr_3257 > 0)
            {
                _arg_1.appendAction("dance", _SafeStr_3257);
            };
            if (_SafeStr_3260 > -1)
            {
                _arg_1.appendAction("sign", _SafeStr_3260);
            };
            if (_SafeStr_3262 > 0)
            {
                _arg_1.appendAction("cri", _SafeStr_3262);
            };
            if (_SafeStr_3263 > 0)
            {
                _arg_1.appendAction("usei", _SafeStr_3263);
            };
            if (_SafeStr_3252)
            {
                _arg_1.appendAction("talk");
            };
            if (((_SafeStr_3253) || (_SafeStr_3254)))
            {
                _arg_1.appendAction("Sleep");
            };
            if (_SafeStr_3255 > 0)
            {
                _local_3 = AvatarAction.getExpression(_SafeStr_3255);
                if (_local_3 != "")
                {
                    switch (_local_3)
                    {
                        case "dance":
                            _arg_1.appendAction("dance", 2);
                            break;
                        default:
                            _arg_1.appendAction(_local_3);
                    };
                };
            };
            if (_SafeStr_3261 > 0)
            {
                _arg_1.appendAction("fx", _SafeStr_3261);
            };
            _arg_1.endActionAppends();
            _SafeStr_1388 = _arg_1.isAnimating();
            var _local_2:int = 2;
            for each (var _local_4:ISpriteDataContainer in _SafeStr_3268.getSprites())
            {
                if (_local_4.id != "avatar")
                {
                    _local_2++;
                };
            };
            if (_local_2 != spriteCount)
            {
                createSprites(_local_2);
            };
            _SafeStr_3248 = _local_2;
            if (_SafeStr_3249)
            {
                for each (var _local_6:IAvatarAddition in _SafeStr_3249)
                {
                    _local_5 = addSprite();
                };
            };
        }

        public function avatarImageReady(_arg_1:String):void
        {
            _forceUpdate = true;
        }

        public function avatarEffectReady(_arg_1:int):void
        {
            _forceUpdate = true;
        }

        protected function get numAdditions():int
        {
            return ((_SafeStr_3249) ? _SafeStr_3249.length : 0);
        }

        public function addAddition(_arg_1:IAvatarAddition):IAvatarAddition
        {
            if (!_SafeStr_3249)
            {
                _SafeStr_3249 = new Map();
            };
            if (_SafeStr_3249.hasKey(_arg_1.id))
            {
                throw (new Error((("Avatar addition with index " + _arg_1.id) + "already exists!")));
            };
            _SafeStr_3249.add(_arg_1.id, _arg_1);
            return (_arg_1);
        }

        public function getAddition(_arg_1:int):IAvatarAddition
        {
            return ((_SafeStr_3249) ? _SafeStr_3249[_arg_1] : null);
        }

        public function removeAddition(_arg_1:int):void
        {
            var _local_2:IAvatarAddition = getAddition(_arg_1);
            if (!_local_2)
            {
                return;
            };
            _SafeStr_3249.remove(_arg_1);
            _local_2.dispose();
        }


    }
}