# list-cfn-unused-export

cf. [CloudFormationで使われていないExportを洗い出す](https://bluepixel.hatenablog.com/entry/2020/05/05/223911)

## Usage

Be sure to setup aws credentials in advance.

```sh
ruby app.rb
```

## Output

all exports shown, which not imported in any stack.

```
following exports value is not used in any stack.
some-export-name1 (defined in some-stack-name1)
some-export-name2 (defined in some-stack-name1)
some-export-name3 (defined in some-stack-name2)
some-export-name4 (defined in some-stack-name3)
```
