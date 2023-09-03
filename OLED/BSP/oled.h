#ifndef __OLED_H__
#define __OLED_H__

#include "font.h"
#include "main.h"
#include "string.h"


//-----------------OLED端口定义---------------- 
#define OLED_SCL_Clr() HAL_GPIO_WritePin(OLED_SPI_SCL_GPIO_Port, OLED_SPI_SCL_Pin, GPIO_PIN_RESET)  // SCL
#define OLED_SCL_Set() HAL_GPIO_WritePin(OLED_SPI_SCL_GPIO_Port, OLED_SPI_SCL_Pin, GPIO_PIN_SET)

#define OLED_SDA_Clr() HAL_GPIO_WritePin(OLED_SPI_SDA_GPIO_Port, OLED_SPI_SDA_Pin, GPIO_PIN_RESET)  // SDA
#define OLED_SDA_Set() HAL_GPIO_WritePin(OLED_SPI_SDA_GPIO_Port, OLED_SPI_SDA_Pin, GPIO_PIN_SET)

#define OLED_RES_Clr() HAL_GPIO_WritePin(OLED_SPI_RES_GPIO_Port, OLED_SPI_RES_Pin, GPIO_PIN_RESET)  // RES
#define OLED_RES_Set() HAL_GPIO_WritePin(OLED_SPI_RES_GPIO_Port, OLED_SPI_RES_Pin, GPIO_PIN_SET)

#define OLED_DC_Clr()  HAL_GPIO_WritePin(OLED_SPI_DC_GPIO_Port, OLED_SPI_DC_Pin, GPIO_PIN_RESET)    // DC
#define OLED_DC_Set()  HAL_GPIO_WritePin(OLED_SPI_DC_GPIO_Port, OLED_SPI_DC_Pin, GPIO_PIN_SET)

typedef enum {
  OLED_COLOR_NORMAL = 0, // 正常模式 黑底白字
  OLED_COLOR_REVERSED    // 反色模式 白底黑字
} OLED_ColorMode;


void OLED_Init();
void OLED_DisPlay_On();
void OLED_DisPlay_Off();

void OLED_NewFrame();
void OLED_ShowFrame();
void OLED_SetPixel(uint8_t x, uint8_t y, OLED_ColorMode color);

void OLED_DrawLine(uint8_t x1, uint8_t y1, uint8_t x2, uint8_t y2, OLED_ColorMode color);
void OLED_DrawRectangle(uint8_t x, uint8_t y, uint8_t w, uint8_t h, OLED_ColorMode color);
void OLED_DrawFilledRectangle(uint8_t x, uint8_t y, uint8_t w, uint8_t h, OLED_ColorMode color);
void OLED_DrawTriangle(uint8_t x1, uint8_t y1, uint8_t x2, uint8_t y2, uint8_t x3, uint8_t y3, OLED_ColorMode color);
void OLED_DrawFilledTriangle(uint8_t x1, uint8_t y1, uint8_t x2, uint8_t y2, uint8_t x3, uint8_t y3, OLED_ColorMode color);
void OLED_DrawCircle(uint8_t x, uint8_t y, uint8_t r, OLED_ColorMode color);
void OLED_DrawFilledCircle(uint8_t x, uint8_t y, uint8_t r, OLED_ColorMode color);
void OLED_DrawEllipse(uint8_t x, uint8_t y, uint8_t a, uint8_t b, OLED_ColorMode color);
void OLED_DrawImage(uint8_t x, uint8_t y, const Image *img, OLED_ColorMode color);

void OLED_PrintASCIIChar(uint8_t x, uint8_t y, char ch, const ASCIIFont *font, OLED_ColorMode color);
void OLED_PrintASCIIString(uint8_t x, uint8_t y, char *str, const ASCIIFont *font, OLED_ColorMode color);
void OLED_PrintString(uint8_t x, uint8_t y, char *str, const Font *font, OLED_ColorMode color);

#endif // __OLED_H__