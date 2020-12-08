#include QMK_KEYBOARD_H

extern keymap_config_t keymap_config;

#ifdef RGBLIGHT_ENABLE
//Following line allows macro to read current RGB settings
  extern rgblight_config_t rgblight_config;
#endif

#ifdef OLED_DRIVER_ENABLE
static uint32_t oled_timer = 0;
#endif

extern uint8_t is_master;

// Each layer gets a name for readability, which is then used in the keymap matrix below.
// The underscores don't mean anything - you can have a layer called STUFF or any other name.
// Layer names don't all need to be of the same length, obviously, and you can also skip them
// entirely and just use numbers.
enum layers {
  _QWERTY,
  _LOWER,
  _RAISE,
  _ADJUST
};

// Custom keycodes for layer keys
// Dual function escape with left command


enum custom_keycodes {
  QWERTY = SAFE_RANGE,
  LOWER,
  RAISE,
  ADJUST,
  MACRO1,
  MACRO2
};

enum {
    TD_PC,
    TD_COMI,
    TD_SLA,
    TD_CAPLOCK,
    TD_ALT,
};


#define KC______ KC_TRNS
#define KC_LOWER LOWER
#define KC_RAISE RAISE
#define KC_RST   RESET
#define KC_LRST  RGBRST


#define KC_TOG  RGB_TOG
#define KC_HUI  RGB_HUI
#define KC_HUD  RGB_HUD
#define KC_SAI  RGB_SAI
#define KC_SAD  RGB_SAD
#define KC_VAI  RGB_VAI
#define KC_SPI  RGB_SPI
#define KC_VAD  RGB_VAD
#define KC_MOD  RGB_MOD
#define KC_SPD  RGB_SPD


#define KC_RSHIFT TD(TD_CAPLOCK) // act as LOWER when hold, as KC_LANG2(=English) when tapped
#define KC_ALT TD(TD_ALT)
#define KC_ALTKN ALT_T(KC_LANG1) 

#define KC_CTLTB CTL_T(KC_TAB)
#define KC_XXXXX KC_NO


const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
[_QWERTY] = LAYOUT_kc( 
  //|-----------------------------------------.                ,-----------------------------------------.
        ESC,     Q,     W,     E,     R,     T,                      Y,     U,     I,     O,     P,  BSPC,
  //|------+------+------+------+------+------|                |------+------+------+------+------+------|
        TAB,     A,     S,     D,     F,     G,                      H,     J,     K,     L,  SCLN,  QUOT,
  //|------+------+------+------+------+------|                |------+------+------+------+------+------|
      LCTRL,     Z,     X,     C,     V,     B,                      N,     M,  COMM,   DOT,  SLSH,  LSFT,
  //|------+------+------+------+------+------+------|  |------+------+------+------+------+------+------|
                                   LGUI, LOWER,   SPC,      ENT, RAISE,   ALT
  //                            `--------------------'  `--------------------'
  ),

[_LOWER] = LAYOUT_kc(
  //,-----------------------------------------.                ,-----------------------------------------.
          1,     2,     3,     4,     5,     6,                      7,     8,     9,     0,  MINS,  BSPC,
  //|------+------+------+------+------+------|                |------+------+------+------+------+------|
        GRV,  PGUP,  PGDN,  HOME,   END,  PSCR,                  XXXXX,  LEFT,  DOWN,    UP, RIGHT,  RBRC,
  //|------+------+------+------+------+------|                |------+------+------+------+------+------|
      CTLTB,  MUTE,  VOLD,  VOLU,  MPLY, XXXXX,                  XXXXX, XXXXX, XXXXX,  NUBS,  LBRC,RSHIFT,
  //|------+------+------+------+------+------+------|  |------+------+------+------+------+------+------|
                                   LGUI, LOWER,   SPC,      ENT, RAISE, ALTKN
  //                            `--------------------'  `--------------------'
  ),


  [_RAISE] = LAYOUT_kc(
  //,-----------------------------------------.                ,-----------------------------------------.
      XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX,                  XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX,
  //|------+------+------+------+------+------|                |------+------+------+------+------+------|
         F1,    F2,    F3,    F4,    F5,    F6,                     F7,    F8,    F9,   F10,   F11,   F12,
  //|------+------+------+------+------+------|                |------+------+------+------+------+------|
      XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX,                  XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX,
  //|------+------+------+------+------+------+------|  |------+------+------+------+------+------+------|
                                   LGUI, LOWER,   SPC,      ENT, RAISE, ALTKN
  //                            `--------------------'  `--------------------'
  ),


[_ADJUST] = LAYOUT_kc(
  //,-----------------------------------------.                ,-----------------------------------------.
        RST, XXXXX, XXXXX, XXXXX, XXXXX,   TOG,                  XXXXX, XXXXX, XXXXX, XXXXX, XXXXX,   PWR,
  //|------+------+------+------+------+------|                |------+------+------+------+------+------|
      XXXXX,   HUI,   SAI,   VAI,   SPI,   MOD,                  XXXXX, XXXXX, XXXXX, XXXXX, XXXXX,   RST,  
  //|------+------+------+------+------+------|                |------+------+------+------+------+------|
      XXXXX,   HUD,   SAD,   VAD,   SPD, XXXXX,                  XXXXX, XXXXX, XXXXX, XXXXX, XXXXX,  SLEP,
  //|------+------+------+------+------+------+------|  |------+------+------+------+------+------+------|
                                   LCTL,  TRNS,   SPC,      SPC,  TRNS,  RALT
  //                             `-------------------'  `--------------------'
)
};


// Tap Dance definitions
qk_tap_dance_action_t tap_dance_actions[] = {
  // Tap once for rshift, twice for capslock
  [TD_CAPLOCK] = ACTION_TAP_DANCE_DOUBLE(KC_LSFT, KC_CAPS),
  [TD_ALT] = ACTION_TAP_DANCE_DOUBLE(KC_RALT, KC_LALT),
};

int RGB_current_mode;

// Setting ADJUST layer RGB back to default
void update_tri_layer_RGB(uint8_t layer1, uint8_t layer2, uint8_t layer3) {
  if (IS_LAYER_ON(layer1) && IS_LAYER_ON(layer2)) {
    layer_on(layer3);
  } else {
    layer_off(layer3);
  }
}

void matrix_init_user(void) {
  #ifdef RGBLIGHT_ENABLE
    RGB_current_mode = rgblight_config.mode;
  #endif
}

void rgb_matrix_indicators_user(void) {
  #ifdef RGB_MATRIX_ENABLE
    switch (biton32(layer_state)) {
      case _RAISE:
        for (int i = 0; i < DRIVER_LED_TOTAL; i++) {
          rgb_matrix_set_color(i, 255, 0, 0);
        }
        break;

      case _LOWER:
        for (int i = 0; i < DRIVER_LED_TOTAL; i++) {
           rgb_matrix_set_color(i, 0, 0, 255);
        }
        break;
      
      case _ADJUST:
        for (int i = 0; i < DRIVER_LED_TOTAL; i++) {
           rgb_matrix_set_color(i, 0, 255, 0);
        }
        break;
      default:
        if (host_keyboard_leds() & (1<<USB_LED_CAPS_LOCK)) {
          for (int i = 0; i < 6; i++) {
            rgb_matrix_set_color(i, 0, 50, 230);
          }
        }
        break;
    }
  #endif
}

#ifdef OLED_DRIVER_ENABLE
  oled_rotation_t oled_init_user(oled_rotation_t rotation) { return OLED_ROTATION_270; }

  void render_space(void) {
    oled_write_P(PSTR("     "), false);
  }

  void render_mod_status_gui_alt(uint8_t modifiers) {
    static const char PROGMEM gui_off_1[] = {0x85, 0x86, 0};
    static const char PROGMEM gui_off_2[] = {0xa5, 0xa6, 0};
    static const char PROGMEM gui_on_1[] = {0x8d, 0x8e, 0};
    static const char PROGMEM gui_on_2[] = {0xad, 0xae, 0};

    static const char PROGMEM alt_off_1[] = {0x87, 0x88, 0};
    static const char PROGMEM alt_off_2[] = {0xa7, 0xa8, 0};
    static const char PROGMEM alt_on_1[] = {0x8f, 0x90, 0};
    static const char PROGMEM alt_on_2[] = {0xaf, 0xb0, 0};

    // fillers between the modifier icons bleed into the icon frames
    static const char PROGMEM off_off_1[] = {0xc5, 0};
    static const char PROGMEM off_off_2[] = {0xc6, 0};
    static const char PROGMEM on_off_1[] = {0xc7, 0};
    static const char PROGMEM on_off_2[] = {0xc8, 0};
    static const char PROGMEM off_on_1[] = {0xc9, 0};
    static const char PROGMEM off_on_2[] = {0xca, 0};
    static const char PROGMEM on_on_1[] = {0xcb, 0};
    static const char PROGMEM on_on_2[] = {0xcc, 0};

    if(modifiers & MOD_MASK_GUI) {
      oled_write_P(gui_on_1, false);
    } else {
      oled_write_P(gui_off_1, false);
    }

    if ((modifiers & MOD_MASK_GUI) && (modifiers & MOD_MASK_ALT)) {
      oled_write_P(on_on_1, false);
    } else if(modifiers & MOD_MASK_GUI) {
      oled_write_P(on_off_1, false);
    } else if(modifiers & MOD_MASK_ALT) {
      oled_write_P(off_on_1, false);
    } else {
      oled_write_P(off_off_1, false);
    }

    if(modifiers & MOD_MASK_ALT) {
      oled_write_P(alt_on_1, false);
    } else {
      oled_write_P(alt_off_1, false);
    }

    if(modifiers & MOD_MASK_GUI) {
      oled_write_P(gui_on_2, false);
    } else {
      oled_write_P(gui_off_2, false);
    }

    if (modifiers & MOD_MASK_GUI & MOD_MASK_ALT) {
      oled_write_P(on_on_2, false);
    } else if(modifiers & MOD_MASK_GUI) {
      oled_write_P(on_off_2, false);
    } else if(modifiers & MOD_MASK_ALT) {
      oled_write_P(off_on_2, false);
    } else {
      oled_write_P(off_off_2, false);
    }

    if(modifiers & MOD_MASK_ALT) {
      oled_write_P(alt_on_2, false);
    } else {
      oled_write_P(alt_off_2, false);
    }
  }


  void render_mod_status_ctrl_shift(uint8_t modifiers) {
      static const char PROGMEM ctrl_off_1[] = {0x89, 0x8a, 0};
      static const char PROGMEM ctrl_off_2[] = {0xa9, 0xaa, 0};
      static const char PROGMEM ctrl_on_1[] = {0x91, 0x92, 0};
      static const char PROGMEM ctrl_on_2[] = {0xb1, 0xb2, 0};

      static const char PROGMEM shift_off_1[] = {0x8b, 0x8c, 0};
      static const char PROGMEM shift_off_2[] = {0xab, 0xac, 0};
      static const char PROGMEM shift_on_1[] = {0xcd, 0xce, 0};
      static const char PROGMEM shift_on_2[] = {0xcf, 0xd0, 0};

      // fillers between the modifier icons bleed into the icon frames
      static const char PROGMEM off_off_1[] = {0xc5, 0};
      static const char PROGMEM off_off_2[] = {0xc6, 0};
      static const char PROGMEM on_off_1[] = {0xc7, 0};
      static const char PROGMEM on_off_2[] = {0xc8, 0};
      static const char PROGMEM off_on_1[] = {0xc9, 0};
      static const char PROGMEM off_on_2[] = {0xca, 0};
      static const char PROGMEM on_on_1[] = {0xcb, 0};
      static const char PROGMEM on_on_2[] = {0xcc, 0};

      if(modifiers & MOD_MASK_CTRL) {
          oled_write_P(ctrl_on_1, false);
      } else {
          oled_write_P(ctrl_off_1, false);
      }

      if ((modifiers & MOD_MASK_CTRL) && (modifiers & MOD_MASK_SHIFT)) {
          oled_write_P(on_on_1, false);
      } else if(modifiers & MOD_MASK_CTRL) {
          oled_write_P(on_off_1, false);
      } else if(modifiers & MOD_MASK_SHIFT) {
          oled_write_P(off_on_1, false);
      } else {
          oled_write_P(off_off_1, false);
      }

      if(modifiers & MOD_MASK_SHIFT) {
          oled_write_P(shift_on_1, false);
      } else {
          oled_write_P(shift_off_1, false);
      }

      if(modifiers & MOD_MASK_CTRL) {
          oled_write_P(ctrl_on_2, false);
      } else {
          oled_write_P(ctrl_off_2, false);
      }

      if (modifiers & MOD_MASK_CTRL & MOD_MASK_SHIFT) {
          oled_write_P(on_on_2, false);
      } else if(modifiers & MOD_MASK_CTRL) {
          oled_write_P(on_off_2, false);
      } else if(modifiers & MOD_MASK_SHIFT) {
          oled_write_P(off_on_2, false);
      } else {
          oled_write_P(off_off_2, false);
      }

      if(modifiers & MOD_MASK_SHIFT) {
          oled_write_P(shift_on_2, false);
      } else {
          oled_write_P(shift_off_2, false);
      }
  }

  void render_logo(void) {
      static const char PROGMEM corne_logo[] = {
          0x80, 0x81, 0x82, 0x83, 0x84,
          0xa0, 0xa1, 0xa2, 0xa3, 0xa4,
          0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0};
      oled_write_P(corne_logo, false);
      oled_write_P(PSTR("corne"), false);
  }

  void render_layer_state(void) {
      static const char PROGMEM default_layer[] = {
          0x20, 0x94, 0x95, 0x96, 0x20,
          0x20, 0xb4, 0xb5, 0xb6, 0x20,
          0x20, 0xd4, 0xd5, 0xd6, 0x20, 0};
      static const char PROGMEM raise_layer[] = {
          0x20, 0x97, 0x98, 0x99, 0x20,
          0x20, 0xb7, 0xb8, 0xb9, 0x20,
          0x20, 0xd7, 0xd8, 0xd9, 0x20, 0};
      static const char PROGMEM lower_layer[] = {
          0x20, 0x9a, 0x9b, 0x9c, 0x20,
          0x20, 0xba, 0xbb, 0xbc, 0x20,
          0x20, 0xda, 0xdb, 0xdc, 0x20, 0};
      static const char PROGMEM adjust_layer[] = {
          0x20, 0x9d, 0x9e, 0x9f, 0x20,
          0x20, 0xbd, 0xbe, 0xbf, 0x20,
          0x20, 0xdd, 0xde, 0xdf, 0x20, 0};
      if(layer_state_is(_ADJUST)) {
          oled_write_P(adjust_layer, false);
      } else if(layer_state_is(_LOWER)) {
          oled_write_P(lower_layer, false);
      } else if(layer_state_is(_RAISE)) {
          oled_write_P(raise_layer, false);
      } else {
          oled_write_P(default_layer, false);
      }
  }

  void render_status_main(void) {
      render_logo();
      render_space();
      render_layer_state();
      render_space();
      render_mod_status_gui_alt(get_mods()|get_oneshot_mods());
      render_mod_status_ctrl_shift(get_mods()|get_oneshot_mods());
  }

  void render_status_secondary(void) {
      render_logo();
      render_space();
      render_layer_state();
      render_space();
      render_mod_status_gui_alt(get_mods()|get_oneshot_mods());
      render_mod_status_ctrl_shift(get_mods()|get_oneshot_mods());
  }

  void oled_task_user(void) {
      if (timer_elapsed32(oled_timer) > 500000) {
          oled_off();
          return;
      }
#ifndef SPLIT_KEYBOARD
      else { oled_on(); }
#endif

      if (is_master) {
          render_status_main();  // Renders the current keyboard state (layer, lock, caps, scroll, etc)
      } else {
          render_status_secondary();
      }
  }

#endif
bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  if (record->event.pressed) {
  #ifdef OLED_DRIVER_ENABLE
    oled_timer = timer_read32();
  #endif
    // set_timelog();
  }

  switch (keycode) {
    case LOWER:
      if (record->event.pressed) {
        layer_on(_LOWER);
        update_tri_layer_RGB(_LOWER, _RAISE, _ADJUST);
      } else {
        layer_off(_LOWER);
        update_tri_layer_RGB(_LOWER, _RAISE, _ADJUST);
      }
      return false;
    case RAISE:
      if (record->event.pressed) {
        layer_on(_RAISE);
        update_tri_layer_RGB(_LOWER, _RAISE, _ADJUST);
      } else {
        layer_off(_RAISE);
        update_tri_layer_RGB(_LOWER, _RAISE, _ADJUST);
      }
      return false;
    case ADJUST:
        if (record->event.pressed) {
          layer_on(_ADJUST);
        } else {
          layer_off(_ADJUST);
        }
        return false;
         case MACRO1:
    if (record->event.pressed) {
            SEND_STRING("aqui el texto de la macro1\nque quieras pegar");
        } else {
            
        }
        return false;
         case MACRO2:
    if (record->event.pressed) {
            SEND_STRING("aqui el texto de la macro2\nque quieras pegar");
        } else {
            
        }
        return false;
      #ifdef RGB_MATRIX_ENABLE
        if (record->event.pressed) {
          eeconfig_update_rgb_matrix_default();
          rgb_matrix_enable();
        }
      #endif
      break;
  }
  return true;
}

#ifdef RGB_MATRIX_ENABLE
  void suspend_power_down_user(void) {
      rgb_matrix_set_suspend_state(true);
  }

  void suspend_wakeup_init_user(void) {
      rgb_matrix_set_suspend_state(false);
  }
#endif
