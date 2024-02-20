import { useBackend } from '../backend';
import { toFixed } from 'common/math';
import { Input, NumberInput, Section, Stack, Box } from '../components';
import { Window } from '../layouts';

export const MatrixEditor = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    matrix_a,
    matrix_b,
    matrix_c,
    matrix_d,
    matrix_e,
    matrix_f,
  } = data;
  return (
    <Window
      title="Nobody Wants to Learn Matrix Math"
      width={400}
      height={300}>
      <Window.Content>
        <Section fill>
          <Stack mt={5} align="baseline" vertical fill>
            <Stack.Item grow>
              <Stack fill>
                <Stack.Item>
                  <Box
                    inline
                    mr={0.25}
                  >
                    D:
                  </Box>
                  <NumberInput
                    value={matrix_a}
                    step={0.005}
                    format={value => toFixed(value, 2)}
                    width="70px"
                    onChange={(e, value) => act('change_var', {
                      var_name: "a",
                      var_value: value,
                    })} />
                </Stack.Item>
                <Stack.Item>
                  <Box
                    inline
                    mr={0.25}
                  >
                    D:
                  </Box>
                  <NumberInput
                    value={matrix_d}
                    step={0.005}
                    format={value => toFixed(value, 2)}
                    width="70px"
                    onChange={(e, value) => act('change_var', {
                      var_name: "d",
                      var_value: value,
                    })} />
                </Stack.Item>
                <Stack.Item>
                  <Input
                    width="102px"
                    backgroundColor="red"
                    placeholder="0 (fixed value)" />
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item grow>
              <Stack fill>
                <Stack.Item>
                  <Box
                    inline
                    mr={0.25}
                  >
                    B:
                  </Box>
                  <NumberInput
                    value={matrix_b}
                    step={0.005}
                    format={value => toFixed(value, 2)}
                    width="70px"
                    onChange={(e, value) => act('change_var', {
                      var_name: "b",
                      var_value: value,
                    })} />
                </Stack.Item>
                <Stack.Item>
                  <Box
                    inline
                    mr={0.25}
                  >
                    E:
                  </Box>
                  <NumberInput
                    value={matrix_e}
                    step={0.005}
                    format={value => toFixed(value, 2)}
                    width="70px"
                    onChange={(e, value) => act('change_var', {
                      var_name: "e",
                      var_value: value,
                    })} />
                </Stack.Item>
                <Stack.Item>
                  <Input
                    width="102px"
                    backgroundColor="red"
                    placeholder="0 (fixed value)" />
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item grow>
              <Stack fill>
                <Stack.Item>
                  <Box
                    inline
                    mr={0.25}
                  >
                    C:
                  </Box>
                  <NumberInput
                    value={matrix_c}
                    step={0.005}
                    format={value => toFixed(value, 2)}
                    width="70px"
                    onChange={(e, value) => act('change_var', {
                      var_name: "c",
                      var_value: value,
                    })} />
                </Stack.Item>
                <Stack.Item>
                  <Box
                    inline
                    mr={0.25}
                  >
                    F:
                  </Box>
                  <NumberInput
                    value={matrix_f}
                    step={0.005}
                    format={value => toFixed(value, 2)}
                    width="70px"
                    onChange={(e, value) => act('change_var', {
                      var_name: "f",
                      var_value: value,
                    })} />
                </Stack.Item>
                <Stack.Item>
                  <Input
                    width="102px"
                    backgroundColor="red"
                    placeholder="1 (fixed value)" />
                </Stack.Item>
              </Stack>
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
