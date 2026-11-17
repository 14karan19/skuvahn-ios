
#import "stdint.h"

typedef struct adpcm_state_t {
	short valprev;
	char index;
} adpcm_state;

struct ima_adpcm_state_s
{
	int variant;
	/*! \brief The size of a chunk, in samples. */
	int chunk_size;
	/*! \brief The last state of the ADPCM algorithm. */
	int last;
	/*! \brief Current index into the step size table. */
	int step_index;
	/*! \brief The current IMA code byte in progress. */
	uint16_t ima_byte;
	int bits;
};
int ima_adpcm_encode(struct ima_adpcm_state_s *s,	 uint8_t ima_data[],  const int16_t amp[], int len);

int adpcm_encoder(short* indata, char* outdata, int len, adpcm_state* state);

void adpcm_decoder(char* indata, short* outdata, int len, adpcm_state* state);

int adpcm_coder(short *indata, unsigned char *outdata, int len, adpcm_state *state);

int decode2(char*inbuff,char*outbuff,int in_len,int out_len);
