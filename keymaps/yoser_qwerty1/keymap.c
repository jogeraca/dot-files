#include QMK_KEYBOARD_H
#include "bootloader.h"
#ifdef PROTOCOL_LUFA
  #include "lufa.h"
  #include "split_util.h"
#endif
#ifdef SSD1306OLED
  #include "ssd1306.h"
#endif

extern keymap_config_t keymap_config;

#ifdef RGBLIGHT_ENABLE
//Following line allows macro to read current RGB settings
extern rgblight_config_t rgblight_config;
#endif

extern uint8_t is_master;


typedef struct {
    bool is_press_action;
    uint8_t state;
} tap;

// Each layer gets a name for readability, which is then used in the keymap matrix below.
// The underscores don't mean anything - you can have a layer called STUFF or any other name.
// Layer names don't all need to be of the same length, obviously, and you can also skip them
// entirely and just use numbers.

enum layers {
    _DVORAK,
    _QWERTY,
    _LOWER,
    _RAISE,
    _ADJUST
};


enum custom_keycodes {
  DVORAK= SAFE_RANGE,
  QWERTY, 
  LOWER,
  RAISE,
  ADJUST,
  BACKLIT,
  RGBRST
};

enum {
    TD_CAPLOCK,
    TD_ALT,
    TD_SUPER,
    TD_BCK,
    TD_FB
};

enum macro_keycodes {
  KC_SAMPLEMACRO,
};

enum {
  SINGLE_TAP = 1,
  SINGLE_HOLD = 2,
  DOUBLE_TAP = 3,
  DOUBLE_HOLD = 4,
  TRIPLE_TAP = 5,
  TRIPLE_HOLD = 6
};

#define KC______ KC_TRNS
#define KC_XXXXX KC_NO
#define KC_LOWER LOWER
#define KC_RAISE RAISE
#define KC_RST   RESET
#define KC_LTOG  RGB_TOG
#define KC_LHUI  RGB_HUI
#define KC_LHUD  RGB_HUD
#define KC_LSAI  RGB_SAI
#define KC_LSAD  RGB_SAD
#define KC_LVAI  RGB_VAI
#define KC_LVAD  RGB_VAD
#define KC_LMOD  RGB_MOD
#define KC_CTLTB CTL_T(KC_TAB)
#define KC_DVORAK DVORAK 
#define KC_QWERTY QWERTY
#define KC_LRST  RGBRST

#define KC_RSHIFT TD(TD_CAPLOCK)
#define KC_SUPER TD(TD_SUPER)
#define KC_ALT TD(TD_ALT)
#define KC_BCK TD(TD_BCK)
#define KC_FB TD(TD_FB)

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [_DVORAK] = LAYOUT_kc( \
  //,-----------------------------------------.                ,-----------------------------------------.
        ESC,  SCLN,  COMM,     E,     R,     T,                      Y,     U,     I,     O,     P,  BCK,
  //|------+------+------+------+------+------|                |------+------+------+------+------+------|
      CTLTB,     T,     O,     E,     U,     I,                      H,     J,     K,     L,  SCLN,  QUOT,
  //|------+------+------+------+------+------|                |------+------+------+------+------+------|
       LSFT,  QUOT,     X,     C,     V,     B,                      N,     M,  COMM,   DOT,  SLSH,  RSFT,
  //|------+------+------+------+------+------+------|  |------+------+------+------+------+------+------|
                                  SUPER, LOWER,   SPC,      ENT, RAISE, ALT  
                              //`--------------------'  `--------------------'
  ),

  [_QWERTY] = LAYOUT_kc( \
  //,-----------------------------------------.                ,-----------------------------------------.
        ESC,     Q,     W,     E,     R,     T,                      Y,     U,     I,     O,     P,  BCK,
  //|------+------+------+------+------+------|                |------+------+------+------+------+------|
      CTLTB,     A,     S,     D,     F,     G,                      H,     J,     K,     L,  SCLN,  QUOT,
  //|------+------+------+------+------+------|                |------+------+------+------+------+------|
       LSFT,     Z,     X,     C,     V,     B,                      N,     M,  COMM,   DOT,  SLSH,  RSFT,
  //|------+------+------+------+------+------+------|  |------+------+------+------+------+------+------|
                                  SUPER, LOWER,   SPC,      ENT, RAISE, ALT  
                              //`--------------------'  `--------------------'
  ),

  [_LOWER] = LAYOUT_kc( \
  //,-----------------------------------------.                ,-----------------------------------------.
          1,     2,     3,     4,     5,     6,                      7,     8,     9,     0,  MINS,  BSPC,
  //|------+------+------+------+------+------|                |------+------+------+------+------+------|
        GRV,  PGUP,  PGDN,  HOME,   END,  PSCR,                    DEL,  LEFT,  DOWN,    UP, RIGHT,   EQL,
  //|------+------+------+------+------+------|                |------+------+------+------+------+------|
      CTLTB,  MUTE,  VOLD,  VOLU,  MPLY, XXXXX,                    MEH, XXXXX,  BSLS,  RBRC,  LBRC,RSHIFT,
  //|------+------+------+------+------+------+------|  |------+------+------+------+------+------+------|
                                  SUPER , LOWER,   SPC,      ENT, RAISE, ALT
                              //`--------------------'  `--------------------'
  ),

  [_RAISE] = LAYOUT_kc( \
 //,-----------------------------------------.                ,-----------------------------------------.
      XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX,                  XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX,
  //|------+------+------+------+------+------|                |------+------+------+------+------+------|
         F1,    F2,    F3,    F4,    F5,    F6,                     F7,    F8,    F9,   F10,   F11,   F12,
  //|------+------+------+------+------+------|                |------+------+------+------+------+------|
      XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX,                  XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX,
  //|------+------+------+------+------+------+------|  |------+------+------+------+------+------+------|
                                   LGUI, LOWER,   SPC,      ENT, RAISE, ALT
                              //`--------------------'  `--------------------'
  ),

  [_ADJUST] = LAYOUT_kc( \
  //,-----------------------------------------.                ,-----------------------------------------.
       LRST, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX,                 DVORAK, QWERTY, XXXXX, XXXXX, XXXXX,   PWR,\
  //|------+------+------+------+------+------|                |------+------+------+------+------+------|
       LTOG,  LHUI,  LSAI,  LVAI, XXXXX, XXXXX,                  XXXXX, XXXXX, XXXXX, XXXXX, XXXXX,   RST,\
  //|------+------+------+------+------+------|                |------+------+------+------+------+------|
       LMOD,  LHUD,  LSAD,  LVAD, XXXXX, XXXXX,                  XXXXX, XXXXX, XXXXX, XXXXX, XXXXX,  SLEP,\
  //|------+------+------+------+------+------+------|  |------+------+------+------+------+------+------|
                                   LGUI, LOWER,   SPC,      ENT, RAISE, ALT
                              //`--------------------'  `--------------------'
  )

};


//tapdance state evaluation
int cur_dance(qk_tap_dance_state_t *state) {
   if (state->count == 1) {
    if (state->pressed) return SINGLE_HOLD;
    else return SINGLE_TAP;
  }
  else if (state->count == 2) {
    if (state->pressed) return DOUBLE_HOLD;
    else return DOUBLE_TAP;
  }
  else if (state->count == 3) {
    if (state->interrupted || !state->pressed)  return TRIPLE_TAP;
    else return TRIPLE_HOLD;
  }
  else return 8;
}

void back_tap(qk_tap_dance_state_t *state, void *user_data) { tap_code(KC_BSPACE); }

void back_finished(qk_tap_dance_state_t *state, void *user_data) { if(!(state->interrupted || !state->pressed)) tap_code16(LCTL(KC_BSPACE)); }

void slash_finished(qk_tap_dance_state_t *state, void *user_data) {
  int td_state = cur_dance(state);
  switch(td_state) {
    case SINGLE_TAP:
      clear_mods();
      clear_weak_mods();
      tap_code(KC_SLSH);
      break;
    case DOUBLE_TAP:
      tap_code(KC_NUBS);
  }
}

void dash_finished(qk_tap_dance_state_t *state, void *user_data) {
  int td_state = cur_dance(state);
  switch(td_state) {
    case SINGLE_TAP:
      tap_code(KC_PMNS);
      break;
    case SINGLE_HOLD:
      register_mods(MOD_BIT(KC_LALT));
      tap_code(KC_KP_0);
      tap_code(KC_KP_1);
      tap_code(KC_KP_5);
      tap_code(KC_KP_1);
      unregister_mods(MOD_BIT(KC_LALT));
      break;
    case DOUBLE_TAP:
      tap_code(KC_PMNS);
      tap_code(KC_PMNS);
  }
}


//void acontrol_alt_shift_finished(qk_tap_dance_state_t *state, void *user_data) {
//  int td_state = cur_dance(state);
//  switch(td_state) {
//    case SINGLE_HOLD:
//      clear_mods();
//      clear_weak_mods();
//      tap_code16(KC_LGUI) //register_mods(MOD_BIT(KC_LGUI));
//      break;
//    case DOUBLE_HOLD:
//      register_mods(MOD_BIT(KC_MEH));
//  }
//}

static tap super_tap_state = {
    .is_press_action = true,
    .state = 0
};

void control_alt_shift_finished(qk_tap_dance_state_t *state, void *user_data) {
  super_tap_state.state = cur_dance(state);
  switch(super_tap_state.state) {
    case SINGLE_HOLD:
      register_code(KC_LGUI);
      break;
    case SINGLE_TAP:
      tap_code(KC_LGUI); 
      break;

    case DOUBLE_TAP:
      tap_code16(KC_MEH); 
      break;

    case DOUBLE_HOLD:
      register_code16(KC_MEH);
      break;

    case 5:
      tap_code(KC_B); 
      break;

    case 6:
      tap_code(KC_C); 
      break;

  }
}

void super_reset(qk_tap_dance_state_t *state, void *user_data) {
  switch (super_tap_state.state) { 
    case SINGLE_HOLD:
      unregister_code(KC_LGUI);
    case DOUBLE_HOLD:
      unregister_code16(KC_MEH);
      //unregister_code16(LGUI_T(LALT(KC_LSFT)));
      break;
  }
  super_tap_state.state = 0;
}

// Tap Dance definitions
qk_tap_dance_action_t tap_dance_actions[] = {
  [TD_ALT] = ACTION_TAP_DANCE_DOUBLE(KC_RALT, KC_LALT),
  [TD_CAPLOCK] = ACTION_TAP_DANCE_DOUBLE(KC_LSFT, KC_CAPS),
  //[TD_FB]  = ACTION_TAP_DANCE_FN_ADVANCED(NULL, slash_finished, NULL),
  //each tap, on finished, and reset. Normally register_code on press unregister on reset so keys can be held down:
  [TD_BCK] = ACTION_TAP_DANCE_FN_ADVANCED(back_tap, back_finished, NULL), 
//[TD_SUPER] = ACTION_TAP_DANCE_FN_ADVANCED(NULL, control_alt_shift_finished, super_reset)
  [TD_SUPER] = ACTION_TAP_DANCE_DOUBLE(KC_LGUI, KC_MEH)
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
    //SSD1306 OLED init, make sure to add #define SSD1306OLED in config.h
    #ifdef SSD1306OLED
      iota_gfx_init(!has_usb());   // turns on the display
    #endif
}

//SSD1306 OLED update loop, make sure to add #define SSD1306OLED in config.h
#ifdef SSD1306OLED

// When add source files to SRC in rules.mk, you can use functions.
const char *read_layer_state(void);
const char *read_logo(void);
void set_keylog(uint16_t keycode, keyrecord_t *record);
const char *read_keylog(void);
const char *read_keylogs(void);

// const char *read_mode_icon(bool swap);
// const char *read_host_led_state(void);
// void set_timelog(void);
// const char *read_timelog(void);

void matrix_scan_user(void) {
   iota_gfx_task();
}

void matrix_render_user(struct CharacterMatrix *matrix) {
  if (is_master) {
    // If you want to change the display of OLED, you need to change here
    matrix_write_ln(matrix, read_layer_state());
    matrix_write_ln(matrix, read_keylog());
    matrix_write_ln(matrix, read_keylogs());
    //matrix_write_ln(matrix, read_mode_icon(keymap_config.swap_lalt_lgui));
    //matrix_write_ln(matrix, read_host_led_state());
    //matrix_write_ln(matrix, read_timelog());
  } else {
    matrix_write(matrix, read_logo());
  }
}

void matrix_update(struct CharacterMatrix *dest, const struct CharacterMatrix *source) {
  if (memcmp(dest->display, source->display, sizeof(dest->display))) {
    memcpy(dest->display, source->display, sizeof(dest->display));
    dest->dirty = true;
  }
}

void iota_gfx_task_user(void) {
  struct CharacterMatrix matrix;
  matrix_clear(&matrix);
  matrix_render_user(&matrix);
  matrix_update(&display, &matrix);
}
#endif//SSD1306OLED


void persistent_default_layer_set(uint16_t default_layer) {
  eeconfig_update_default_layer(default_layer);
  default_layer_set(default_layer);
}
bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  if (record->event.pressed) {
    #ifdef SSD1306OLED
       set_keylog(keycode, record);
    #endif
  }

  switch (keycode) {
    case DVORAK:
      if (record->event.pressed) {
        persistent_default_layer_set(1UL<<_DVORAK);
      }
      return false;
      break;
    case QWERTY:
      if (record->event.pressed) {
        persistent_default_layer_set(1UL<<_QWERTY);
      }
      return false;
      break;
    case LOWER:
      if (record->event.pressed) {
        layer_on(_LOWER);
        update_tri_layer_RGB(_LOWER, _RAISE, _ADJUST);
      } else {
        layer_off(_LOWER);
        update_tri_layer_RGB(_LOWER, _RAISE, _ADJUST);
      }
      return false;
      break;
    case RAISE:
      if (record->event.pressed) {
        layer_on(_RAISE);
        update_tri_layer_RGB(_LOWER, _RAISE, _ADJUST);
      } else {
        layer_off(_RAISE);
        update_tri_layer_RGB(_LOWER, _RAISE, _ADJUST);
      }
      return false;
      break;
    case ADJUST:
        if (record->event.pressed) {
          layer_on(_ADJUST);
        } else {
          layer_off(_ADJUST);
        }
        return false;
        break;
    case RGB_MOD:
      #ifdef RGBLIGHT_ENABLE
        if (record->event.pressed) {
          rgblight_mode(RGB_current_mode);
          rgblight_step();
          RGB_current_mode = rgblight_config.mode;
        }
      #endif
      return false;
      break;
    case RGBRST:
      #ifdef RGBLIGHT_ENABLE
        if (record->event.pressed) {
          eeconfig_update_rgblight_default();
          rgblight_enable();
          RGB_current_mode = rgblight_config.mode;
        }
      #endif
      break;
  }
  return true;
}
